package filter

import (
	"context"
	"net/http"
	"thrc/infra/redis"
	"thrc/interface/account/model"
	"thrc/interface/account/util"
)

var (
	tokenPrefix = "token:"
	redisCli    *redis.RedisClient
)

func init() {
	redisCli = redis.NewRedisCli()
}

func UserAuthFilter(ctx context.Context, w http.ResponseWriter, req *http.Request) bool {
	query := req.URL.Query()
	token := req.Header.Get("token")
	userid := query.Get("user_id")
	if token != "" {
		id, err := redisCli.Get(tokenPrefix + token)
		if err != nil {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "can't find token"})
			return false
		}
		if id == "" || userid != id {
			util.SendJsonResp(w, &model.Response{Code: -1, Msg: "token verification fail"})
			return false
		}
	} else {
		util.SendJsonResp(w, &model.Response{Code: -1, Msg: "token can't be nil"})
		return false
	}
	return true
}
