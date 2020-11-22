package service

import (
	"context"
	"encoding/json"
	"github.com/afex/hystrix-go/hystrix"
	"net/http"
	"thrc/infra/minio"
	"thrc/infra/redis"
	"thrc/interface/account/model"
	"thrc/interface/account/uploader"
	"thrc/interface/account/util"
	acc "thrc/service/account/model"
	asvr "thrc/service/account/service/grpc/client"
	"thrc/service/account/service/grpc/proto/account"
	usr "thrc/service/user/model"
	usvr "thrc/service/user/service/grpc/client"
	"thrc/service/user/service/grpc/proto/user"
	"thrc/tools/rand"
	"thrc/tools/uuid"
)

var (
	tokenPrefix   = "token:"
	hystrixConfig = &hystrix.CommandConfig{
		Timeout:               1000,
		MaxConcurrentRequests: 100,
		ErrorPercentThreshold: 25,
	}
)

type Service struct {
	accCli   *asvr.AccountClient
	usrCli   *usvr.UserClient
	redisCli *redis.RedisClient
	minioCli *minio.MinioCli
}

func NewService(acc *asvr.AccountClient, usr *usvr.UserClient, redis *redis.RedisClient, minio *minio.MinioCli) *Service {
	hystrixcmdconfig := make(map[string]hystrix.CommandConfig)
	hystrixcmdconfig["CreateAccount"] = *hystrixConfig
	hystrixcmdconfig["CreateUser"] = *hystrixConfig
	hystrixcmdconfig["GetIdByMobile"] = *hystrixConfig
	hystrixcmdconfig["GetPasswordById"] = *hystrixConfig
	hystrixcmdconfig["UpdatePasswdById"] = *hystrixConfig
	hystrixcmdconfig["UpdateUserByUID"] = *hystrixConfig
	hystrixcmdconfig["GetUserIdByID"] = *hystrixConfig
	hystrixcmdconfig["UploadAvatar"] = *hystrixConfig
	hystrixcmdconfig["UpdateAvatarByUID"] = *hystrixConfig
	hystrixcmdconfig["GetUserByUID"] = *hystrixConfig
	hystrix.Configure(hystrixcmdconfig)
	return &Service{
		accCli:   acc,
		usrCli:   usr,
		redisCli: redis,
		minioCli: minio,
	}
}

func (s *Service) Register(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	mobile := query.Get("mobile")
	passwd := query.Get("password")
	if passwd != "" {
		userID := rand.GenerateRandNum(10)
		accountInfo := &account.AccountReq{
			UserID:   userID,
			Mobile:   mobile,
			Password: passwd}
		err := hystrix.Do("CreateAccount", func() error {
			_, err := s.accCli.Call.CreateAccount(ctx, accountInfo)
			return err
		}, nil)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "create account fail"})
			return
		}
		userInfo := &user.UserReq{
			UserID:   userID,
			Name:     mobile,
			Mobile:   mobile,
			Sex:      "U",
			Birthday: "1949-10-01"}
		err = hystrix.Do("CreateUser", func() error {
			_, err = s.usrCli.Call.CreateUser(ctx, userInfo)
			return err
		}, nil)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "create user info fail"})
			return
		}
		util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "create account success"})
	} else {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "password can't be nil"})
	}
}

func (s *Service) LoginByPassword(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	mobile := query.Get("mobile")
	passwd := query.Get("password")
	if mobile != "" && passwd != "" {
		var resp *account.AccountResp
		err := hystrix.Do("GetIdByMobile", func() error {
			r, err := s.accCli.Call.GetIdByMobile(ctx, &account.AccountReq{Mobile: mobile})
			resp = r
			return err
		}, nil)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: err.Error()})
			return
		}
		id := resp.Data
		err = hystrix.Do("GetPasswordById", func() error {
			r, err := s.accCli.Call.GetPasswordById(ctx, &account.AccountReq{ID: id})
			resp = r
			return err

		}, nil)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: err.Error()})
			return
		}
		var p acc.Password
		err = json.Unmarshal([]byte(resp.Data), &p)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't unmarshal rpc resp"})
			return
		}
		if util.MatchPassword(&p, passwd) {
			token := uuid.GenCanonical()
			err = s.redisCli.SetEx(tokenPrefix+token, id, 86400)
			if err != nil {
				util.SendJsonResp(w, &model.Response{Code: -1, Msg: "login error"})
				return
			}
			obj := make(map[string]interface{})
			obj["token"] = token
			obj["user_id"] = id
			util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "login success", Data: obj})
		} else {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "incorrect password"})
		}
	} else {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "mobile or password can't be empty"})
	}
}

func (s *Service) Logout(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	token := req.Header.Get("token")
	count, err := s.redisCli.Del(tokenPrefix + token)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "del token fail"})
		return
	}
	if count >= 1 {
		util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "logout success"})
	}
}

func (s *Service) ChangePassword(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	userID := query.Get("user_id")
	oldPasswd := query.Get("old_password")
	newPasswd := query.Get("new_password")
	if userID != "" {
		var resp *account.AccountResp
		err := hystrix.Do("GetPasswordById", func() error {
			r, err := s.accCli.Call.GetPasswordById(ctx, &account.AccountReq{ID: userID})
			resp = r
			return err

		}, nil)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: err.Error()})
			return
		}
		var p acc.Password
		err = json.Unmarshal([]byte(resp.Data), &p)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't unmarshal rpc util.SendJsonResp"})
			return
		}
		if util.MatchPassword(&p, oldPasswd) {
			err := hystrix.Do("UpdatePasswdById", func() error {
				_, err = s.accCli.Call.UpdatePasswdById(ctx, &account.AccountReq{
					ID:       userID,
					Password: newPasswd})
				return err
			}, nil)
			if err != nil {
				util.SendJsonResp(w, &model.Response{Code: -1, Msg: "update password fail"})
				return
			}
			util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "update password success"})
		}
	}
}

func (s *Service) VerifyPassword(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	userid := query.Get("user_id")
	var resp *account.AccountResp
	err := hystrix.Do("GetPasswordById", func() error {
		r, err := s.accCli.Call.GetPasswordById(ctx, &account.AccountReq{ID: userid})
		resp = r
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: err.Error()})
		return
	}
	var p acc.Password
	err = json.Unmarshal([]byte(resp.Data), &p)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't unmarshal rpc util.SendJsonResp"})
		return
	}
	if util.MatchPassword(&p, query.Get("password")) {
		util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "password verify success"})
		return
	} else {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "password verify fail"})
		return
	}
}

func (s *Service) UpdateUserInfo(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	userid := query.Get("user_id")
	var aresp *account.AccountResp
	err := hystrix.Do("GetUserIdByID", func() error {
		a, err := s.accCli.Call.GetUserIdByID(ctx, &account.AccountReq{ID: userid})
		aresp = a
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't get user id"})
		return
	}
	uid := aresp.Data
	err = hystrix.Do("UpdateUserByUID", func() error {
		_, err := s.usrCli.Call.UpdateUserByUID(ctx,
			&user.UserReq{UserID: uid,
				Name:     query.Get("name"),
				Mobile:   query.Get("mobile"),
				Email:    query.Get("email"),
				Birthday: query.Get("birthday"),
				Sex:      query.Get("sex")})
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "update user info fail"})
		return
	}
	util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "update user info success"})
}

func (s *Service) UploadAvatar(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	userid := req.Header.Get("user_id")
	var aresp *account.AccountResp
	err := hystrix.Do("GetUserIdByID", func() error {
		a, err := s.accCli.Call.GetUserIdByID(ctx, &account.AccountReq{ID: userid})
		aresp = a
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't get user id"})
		return
	}
	uid := aresp.Data
	reader, err := req.MultipartReader()
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "get multipart reader fail"})
	}
	part, err := reader.NextPart()
	var uploadedURL string
	err = hystrix.Do("UploadAvatar", func() error {
		url, err := uploader.UploadAvatar(part, part.FileName())
		uploadedURL = url
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "update avatar fail"})
		return
	}
	var uresp *user.UserResp
	err = hystrix.Do("UpdateAvatarByUID", func() error {
		u, err := s.usrCli.Call.UpdateAvatarByUID(ctx,
			&user.UserReq{UserID: uid,
				AvatarURL: uploadedURL})
		uresp = u
		return err
	}, nil)
	if err != nil || uresp.Code != 1000 {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "update avatar fail"})
		return
	}
	util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "update avatar success", Data: uploadedURL})
}

func (s *Service) GetUserInfo(ctx context.Context, w http.ResponseWriter, req *http.Request) {
	query := req.URL.Query()
	userid := query.Get("user_id")
	var aresp *account.AccountResp
	err := hystrix.Do("GetUserIdByID", func() error {
		a, err := s.accCli.Call.GetUserIdByID(ctx, &account.AccountReq{ID: userid})
		aresp = a
		return err
	}, nil)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't get user id"})
		return
	}
	uid := aresp.Data
	var uresp *user.UserResp
	err = hystrix.Do("GetUserByUID", func() error {
		u, err := s.usrCli.Call.GetUserByUID(ctx, &user.UserReq{UserID: uid})
		uresp = u
		return err
	}, nil)
	if err != nil || uresp.Code != 1000 {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "get user info fail"})
		return
	}
	var userinfo usr.User
	err = json.Unmarshal(json.RawMessage(uresp.GetData()), &userinfo)
	if err != nil {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "json unmarshal fail"})
		return
	}
	util.SendJsonResp(w, &model.Response{Code: 1000, Msg: "get user info success", Data: userinfo})
}
