package main

import (
	"log"
	"thrc/infra/discovery"
	"thrc/infra/http/proxy"

	//"thrc/infra/http"
	"net/http"
	httpresolver "thrc/infra/discovery/http"
	"thrc/interface/gateway/conf"
)

var (
	HttpServerConfig = &discovery.AppConfig{
		Region: "cn",
		Zone:   "gd",
		Env:    "dev",
	}
)

func main() {
	nodeInfo := conf.GetNodeInfo()

	r := httpresolver.NewHttpResolver(HttpServerConfig)
	if r == nil {
		log.Fatal("can't get http service resolver")
	}
	proxy := proxy.NewProxy("/api/v1", r)
	//s := new(http.Http)
	//s.Init(conf.GetPort())
	go func() {
		log.Fatal(http.ListenAndServe(":"+conf.GetPort(), proxy.Handler))
	}()

	dis, err := discovery.NewDiscovery()
	if err != nil {
		log.Fatal(err)
	}
	dis.Register(nodeInfo)
	select {}
}
