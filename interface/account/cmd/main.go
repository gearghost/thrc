package main

import (
	"log"
	"thrc/infra/discovery"
	"thrc/infra/http"
	"thrc/infra/minio"
	"thrc/infra/redis"
	"thrc/interface/account/conf"
	"thrc/interface/account/filter"
	svr "thrc/interface/account/service"
	asvr "thrc/service/account/service/grpc/client"
	usvr "thrc/service/user/service/grpc/client"

	"github.com/opentracing/opentracing-go"
	gresolver "thrc/infra/discovery/grpc"
)

var (
	accountAppID = "thrc.account"
	userAppID    = "thrc.user"
	accountCfg   = &discovery.AppConfig{
		Region: "cn",
		Zone:   "gd",
		Env:    "dev",
	}
	usrCfg = &discovery.AppConfig{
		Region: "cn",
		Zone:   "gd",
		Env:    "dev",
	}
)

func main() {
	nodeinfo := conf.GetNodeInfo()
	r1 := gresolver.NewResolver(accountAppID, accountCfg)
	if r1 == nil {
		log.Fatal("can't get account resolver")
	}
	accCli, err := asvr.GetClient(r1, accountAppID, opentracing.GlobalTracer())
	if err != nil {
		log.Fatal(err)
	}

	r2 := gresolver.NewResolver(userAppID, usrCfg)
	if r2 == nil {
		log.Fatal("can't get user resolver")
	}
	usrCli, err := usvr.GetClient(r2, userAppID, opentracing.GlobalTracer())
	if err != nil {
		log.Fatal(err)
	}
	redisCli := redis.NewRedisCli()
	minioCli, err := minio.NewMinioCli()
	if err != nil {
		log.Fatal(err)
	}

	service := svr.NewService(accCli, usrCli, redisCli, minioCli)

	s := new(http.Http)
	s.Init(conf.GetPort())
	innerRouter(s, service)
	dis, err := discovery.NewDiscovery()
	if err != nil {
		log.Fatal(err)
	}
	dis.Register(nodeinfo)
	select {}
}

func innerRouter(engine *http.Http, svr *svr.Service) {
	pg := engine.Group("/account", nil, nil)
	pg.Post("/register", svr.Register, nil)
	pg.Post("/loginbypassword", svr.LoginByPassword, nil)
	pg.Post("/logout", svr.Logout, filter.UserAuthFilter)
	pg.Post("/changepassword", svr.ChangePassword, filter.UserAuthFilter)
	pg.Get("/verifypassword", svr.VerifyPassword, filter.UserAuthFilter)
	pg.Post("/updateuser", svr.UpdateUserInfo, filter.UserAuthFilter)
	pg.Post("/uploadavatar", svr.UploadAvatar, filter.UserAuthFilter)
	pg.Post("/getuserinfo", svr.GetUserInfo, filter.UserAuthFilter)
}
