package conf

import (
	"thrc/infra/apollo"
	"thrc/infra/discovery"
	"thrc/tools/net"
	"thrc/tools/rand"
)

const (
	scheme = "http://"
)

var (
	config *apollo.ApolloClient
)

func init() {
	config = apollo.NewApolloClient("application", "thrc-gateway", "1904f8f8aef046f6bced887a97d8f3c6")
}

func GetPort() string {
	return config.Get("port").(string)
}

func GetNodeInfo() *discovery.NodeInfo {
	//discovery config
	port := config.Get("port").(string)
	region := config.Get("region").(string)
	zone := config.Get("zone").(string)
	env := config.Get("env").(string)
	appid := config.Get("appid").(string)
	addr := scheme + net.LocalIP() + ":" + port
	return &discovery.NodeInfo{
		Region:   region,
		Zone:     zone,
		Env:      env,
		AppID:    appid,
		Hostname: rand.GenerateRandNum(6),
		Addrs:    []string{addr},
	}
}
