package server

import (
	"database/sql"
	"encoding/json"
	"thrc/service/account/dao"
	"thrc/service/account/model"
	"thrc/service/account/service/grpc/proto/account"
	"thrc/tools/md5"
	"thrc/tools/rand"
	"thrc/tools/uuid"
	"time"

	"golang.org/x/net/context"
)

type Server struct {
	accountDAO *dao.AccountDAO
}

func New(db *sql.DB) *Server {
	dao := dao.NewAccountDAO(db)
	return &Server{accountDAO: dao}
}

func (s *Server) Reload(db *sql.DB) {
	s.accountDAO = dao.NewAccountDAO(db)
}

func (s *Server) CreateAccount(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	salt := rand.GenerateRandNum(6)
	passwd := md5.EncryptWithSalt(in.Password, salt)
	_, err := s.accountDAO.CreateAccount(&model.Account{
		Id:         uuid.Generate(),
		UserId:     in.UserID,
		Mobile:     in.Mobile,
		Email:      in.Email,
		Salt:       salt,
		Password:   passwd,
		Remark:     in.Remark,
		CreateTime: time.Now(),
		UpdateTime: time.Now()})
	if err != nil {
		return newResp(-1, "insert account info into database fail", ""), err
	}
	return newResp(1000, "create account success", ""), nil
}

func (s *Server) CheckAccountExistByMobile(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	mobile := in.Mobile
	count, err := s.accountDAO.CheckAccountExistByMobile(mobile)
	if err != nil {
		return newResp(-1, "get count from database fail", ""), err
	}
	if count == 0 {
		return newResp(-1, "account isn't exist", ""), nil
	}
	return newResp(1000, "account is exist", ""), nil
}

func (s *Server) GetIdByMobile(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	mobile := in.Mobile
	id, err := s.accountDAO.GetIdByMobile(mobile)
	if err != nil {
		return newResp(-1, "get id from database fail", ""), err
	}
	return newResp(1000, "get id by mobile success", id), nil
}

func (s *Server) GetPasswordByMobile(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	mobile := in.Mobile
	passwd, salt, err := s.accountDAO.GetPasswordByMobile(mobile)
	if err != nil {
		return newResp(-1, "get passwd from database fail", ""), err
	}
	data := &model.Password{Passwd: passwd, Salt: salt}
	result, err := json.Marshal(data)
	if err != nil {
		return newResp(-1, "can't marshal password", ""), err
	}
	return newResp(1000, "get password success", string(result)), nil
}

func (s *Server) GetPasswordById(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	id := in.ID
	passwd, salt, err := s.accountDAO.GetPasswordById(id)
	if err != nil {
		return newResp(-1, "get passwd from database fail", ""), err
	}
	data := &model.Password{Passwd: passwd, Salt: salt}
	result, err := json.Marshal(data)
	if err != nil {
		return newResp(-1, "can't marshal password", ""), err
	}
	return newResp(1000, "get password by id", string(result)), nil
}

func (s *Server) GetUserIdByID(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	id := in.ID
	userid, err := s.accountDAO.GetUserIdByID(id)
	if err != nil {
		return newResp(-1, "get user id from database fail", ""), err
	}
	return newResp(1000, "get userid success", userid), nil
}

func (s *Server) GetAccountByUID(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	uid := in.UserID
	a, err := s.accountDAO.GetAccountByUID(uid)
	if err != nil {
		return newResp(-1, "get account from database fail", ""), err
	}
	result, err := json.Marshal(a)
	if err != nil {
		return newResp(-1, "can't marshal account", ""), err
	}
	return newResp(1000, "get account by uid success", string(result)), nil
}

func (s *Server) GetAccountByMobile(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	mobile := in.Mobile
	a, err := s.accountDAO.GetAccountByMobile(mobile)
	if err != nil {
		return newResp(-1, "get account from database fail", ""), err
	}
	result, err := json.Marshal(a)
	if err != nil {
		return newResp(-1, "can't marshal account", ""), err
	}
	return newResp(1000, "get account by mobile", string(result)), nil
}

func (s *Server) UpdateAccountById(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	_, err := s.accountDAO.UpdateAccountById(&model.Account{
		Id:     in.ID,
		Mobile: in.Mobile,
		Email:  in.Email,
		Remark: in.Remark})
	if err != nil {
		return newResp(-1, "update account into database fail", ""), err
	}
	return newResp(1000, "update account success", ""), nil
}

func (s *Server) UpdatePasswdById(ctx context.Context, in *account.AccountReq) (*account.AccountResp, error) {
	_, salt, err := s.accountDAO.GetPasswordById(in.ID)
	if err != nil {
		return newResp(-1, "get salt from database fail", ""), err
	}
	passwd := md5.EncryptWithSalt(in.Password, salt)
	_, err = s.accountDAO.UpdatePasswdById(passwd, in.ID)
	if err != nil {
		return newResp(-1, "update password into database fail", ""), err
	}
	return newResp(1000, "update password success", ""), nil
}

func newResp(code int32, msg string, data string) *account.AccountResp {
	return &account.AccountResp{Code: code, Message: msg, Data: data}
}
