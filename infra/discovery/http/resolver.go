package http

import (
	"go.etcd.io/etcd/clientv3"
	"log"
	"net/url"
	"regexp"
	"strings"
	"sync"
	"thrc/infra/discovery"
)

type HttpResolver struct {
	disCli   *discovery.Client
	appCfg   *discovery.AppConfig
	lock     sync.RWMutex
	svrHosts map[string][]*url.URL
}

func NewHttpResolver(appcfg *discovery.AppConfig) *HttpResolver {
	d := discovery.NewDiscoveryCli("", appcfg)
	if d == nil {
		return nil
	}
	r := &HttpResolver{
		disCli: d,
		appCfg: appcfg,
	}
	return r
}

func (r *HttpResolver) Resolve(hosts map[string][]*url.URL) {
	r.svrHosts = hosts
	r.disCli.Watch("", r.watch)
}

func (r *HttpResolver) watch(ch clientv3.WatchChan) {
	nodes := r.disCli.GetNodes()
	if len(nodes) == 0 {
		log.Println(" no node available now")
	} else {
		for _, v := range nodes {
			for _, addr := range v.Addrs {
				a, isHttp := getHttpAddress(addr)
				if isHttp == true {
					addServiceHost(r.svrHosts, v.AppID, a)
				}
			}
		}
	}
	go func(clientv3.WatchChan) {
		for {
			select {
			case msg := <-ch:
				for _, ev := range msg.Events {
					log.Printf("Receive: %s %q: %q\n", ev.Type, ev.Kv.Key, ev.Kv.Value)
					value := string(ev.Kv.Value)
					if ev.Type == 0 {
						node := discovery.GetNodeByStr(value)
						log.Println("add node: ", node.Hostname)
						searchTree := generateRegexpTree(r.appCfg.Region, r.appCfg.Zone,
							r.appCfg.Env, "")
						key := generateTree(node.Region, node.Zone, node.Env) + "/" + node.AppID
						isMatched := matchTree(key, searchTree)
						if isMatched {
							r.lock.Lock()
							r.disCli.AddNode(node)
							for _, v := range node.Addrs {
								addr, isHttp := getHttpAddress(v)
								if isHttp {
									addServiceHost(r.svrHosts, node.AppID, addr)
									log.Println("add http service:", node.AppID, node.Hostname)
								}
							}
							r.lock.Unlock()
							log.Println("added node: ", node.Hostname, node.Addrs)
						}

					} else {
						hostname := getHostnameByKey(string(ev.Kv.Key))
						node := r.getCacheByHostname(hostname)
						log.Println("delete node: ", node.Hostname)
						r.lock.Lock()
						for _, v := range node.Addrs {
							addr, isHttp := getHttpAddress(v)
							if isHttp {
								removeServiceHost(r.svrHosts, node.AppID, addr)
								log.Println("remove http service:", node.AppID, node.Hostname)
							}
						}
						r.disCli.RemoveNode(node)
						log.Println("deleted node: ", node.Hostname, node.Addrs)
						r.lock.Unlock()
					}
				}
			}
		}
	}(ch)
}

func (r *HttpResolver) getCacheByHostname(hostname string) *discovery.Node {
	for _, v := range r.disCli.GetNodes() {
		if v.Hostname == hostname {
			return v
		}
	}
	return nil
}

func getHostnameByKey(key string) string {
	return strings.Split(key, "/")[5]
}

func generateRegexpTree(region, zone, env, appid string) string {
	appPath := generateSearchTree(region, zone, env, appid)
	regtext := strings.Replace(appPath, "*", "\\w*", -1)
	return regtext
}

func generateSearchTree(region, zone, env, appid string) string {
	var appPath string
	if region == "" {
		appPath = "/*"
	} else {
		appPath = "/" + region
	}
	if zone == "" {
		appPath += "/*"
	} else {
		appPath += "/" + zone
	}
	if env == "" {
		appPath += "/*"
	} else {
		appPath += "/" + env
	}
	if appid == "" {
		appPath += "/*"
	} else {
		appPath += "/" + appid
	}
	return appPath
}

func generateTree(region, zone, env string) string {
	return "/" + region + "/" + zone + "/" + env
}

func matchTree(tree, matchtree string) bool {
	matched, err := regexp.MatchString(matchtree, tree)
	if err != nil {
		return false
	}
	return matched
}

func getHttpAddress(addr string) (string, bool) {
	isRPCAddr := strings.HasPrefix(addr, "http://")
	if isRPCAddr {
		a := strings.TrimPrefix(addr, "http://")
		return a, true
	}
	return "", false
}

func addServiceHost(hosts map[string][]*url.URL, key, addr string) {
	hosts[key] = append(hosts[key], &url.URL{
		Scheme: "http",
		Host:   addr},
	)
}
func removeServiceHost(hosts map[string][]*url.URL, key, addr string) {
	nodes, isExist := hosts[key]
	if isExist {
		for i, v := range nodes {
			if v.Host == addr {
				hosts[key] = append(hosts[key][:i], hosts[key][i+1:]...)
			}
		}
	}
}
