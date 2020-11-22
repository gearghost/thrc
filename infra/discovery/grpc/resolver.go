package grpc

import (
	"errors"
	"go.etcd.io/etcd/clientv3"
	"google.golang.org/grpc/resolver"
	"log"
	"regexp"
	"strings"
	"sync"
	"thrc/infra/discovery"
)

const (
	scheme = "ns"
)

type GRPCResolver struct {
	disCli     *discovery.Client
	appCfg     *discovery.AppConfig
	appid      string
	clientConn resolver.ClientConn
	lock       sync.RWMutex
}

func NewResolver(appid string, appcfg *discovery.AppConfig) resolver.Builder {
	d := discovery.NewDiscoveryCli(appid, appcfg)
	return &GRPCResolver{
		disCli: d,
		appid:  appid,
		appCfg: appcfg,
	}
}

func (r *GRPCResolver) Scheme() string {
	return scheme
}

func (r *GRPCResolver) ResolveNow(rn resolver.ResolveNowOptions) {
	log.Println("ResolveNow")
}

func (r *GRPCResolver) Close() {
	log.Println("Resolver close")
}

func (r *GRPCResolver) Build(target resolver.Target, clientConn resolver.ClientConn, opts resolver.BuildOptions) (resolver.Resolver, error) {
	if r.disCli == nil {
		d := discovery.NewDiscoveryCli(r.appid, r.appCfg)
		if d == nil {
			return nil, errors.New("can't create discovery client")
		}
		r.disCli = d
	}
	r.clientConn = clientConn
	r.disCli.Watch(target.Endpoint, r.watch)
	return r, nil
}

func (r *GRPCResolver) watch(ch clientv3.WatchChan) {
	var nodeAddrs []resolver.Address
	nodes := r.disCli.GetNodes()
	if len(nodes) == 0 {
		log.Println("AppID:", r.appid, " no node available now")
	} else {
		for _, v := range nodes {
			for _, addr := range v.Addrs {
				a, isgRPC := getRPCAddress(addr)
				if isgRPC == true {
					nodeAddrs = append(nodeAddrs, resolver.Address{Addr: a})
				}
			}
		}
	}

	r.clientConn.NewAddress(nodeAddrs)

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
							r.appCfg.Env, r.appid)
						key := generateTree(node.Region, node.Zone, node.Env) + "/" + node.AppID
						isMatched := matchTree(key, searchTree)
						if isMatched {
							r.lock.Lock()
							r.disCli.AddNode(node)
							for _, v := range node.Addrs {
								addr, isRPC := getRPCAddress(v)
								if isRPC == true && !exists(nodeAddrs, addr) {
									nodeAddrs = append(nodeAddrs, resolver.Address{Addr: addr})
									r.clientConn.NewAddress(nodeAddrs)
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
						isRemoved := false
						for _, v := range node.Addrs {
							addr, isRPC := getRPCAddress(v)
							if isRPC == true && !exists(nodeAddrs, addr) {
								addrs, isOk := remove(nodeAddrs, addr)
								if isOk {
									nodeAddrs = addrs
									isRemoved = isOk
								}
							}
						}
						if isRemoved {
							r.clientConn.NewAddress(nodeAddrs)
						}
						i := r.disCli.RemoveNode(node)
						log.Println("deleted node idx: ", i)
						r.lock.Unlock()
					}
				}
			}
		}
	}(ch)
}

func (r *GRPCResolver) getCacheByHostname(hostname string) *discovery.Node {
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

func exists(addrs []resolver.Address, addr string) bool {
	for i := range addrs {
		if addrs[i].Addr == addr {
			return true
		}
	}
	return false
}

func getRPCAddress(addr string) (string, bool) {
	isRPCAddr := strings.HasPrefix(addr, "grpc://")
	if isRPCAddr {
		a := strings.TrimPrefix(addr, "grpc://")
		return a, true
	}
	return "", false
}

func remove(addrs []resolver.Address, addr string) ([]resolver.Address, bool) {
	for i := range addrs {
		if addrs[i].Addr == addr {
			addrs = append(addrs[:i], addrs[i+1:]...)
			return addrs, true
		}
	}
	return addrs, false
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
