package util

import (
	"encoding/json"
	"net/http"
	"thrc/service/account/model"
	"thrc/tools/md5"
)

func SendJsonResp(w http.ResponseWriter, resp interface{}) {
	w.Header().Set("Content-Type", "application/json")
	j, _ := json.Marshal(resp)
	w.Write(j)
}

func MatchPassword(p *model.Password, password string) bool {
	if md5.EncryptWithSalt(password, p.Salt) == p.Passwd {
		return true
	}
	return false
}
