package proxy

import (
	"math/rand"
	"net/http"
	"net/http/httputil"
	"net/url"
	"strings"
	httpresolver "thrc/infra/discovery/http"
)

type Proxy struct {
	targets  map[string][]*url.URL
	reslover *httpresolver.HttpResolver
	Handler  *httputil.ReverseProxy
}

func (p *Proxy) AddServiceHost(key, addr string) {
	p.targets[key] = append(p.targets[key], &url.URL{
		Scheme: "http",
		Host:   addr},
	)
}
func (p *Proxy) RemoveServiceHost(key, addr string) {
	nodes, isExist := p.targets[key]
	if isExist {
		for i, v := range nodes {
			if v.Host == addr {
				p.targets[key] = append(p.targets[key][:i], p.targets[key][i+1:]...)
			}
		}
	}
}

func NewProxy(prefix string, r *httpresolver.HttpResolver) *Proxy {
	p := &Proxy{
		targets:  make(map[string][]*url.URL, 50),
		reslover: r,
	}
	p.Handler = newReverseProxy(prefix, p.targets)
	p.reslover.Resolve(p.targets)
	return p
}

func newReverseProxy(prefix string, targets map[string][]*url.URL) *httputil.ReverseProxy {
	director := func(req *http.Request) {
		if !strings.HasPrefix(req.URL.Path, prefix) {
			return
		}
		nextReq := strings.TrimPrefix(req.URL.Path, prefix)
		serviceName := strings.Split(nextReq, "/")[1]
		services, isOk := targets[serviceName]
		if isOk {
			count := len(services)
			if count > 0 {
				target := services[rand.Int()%count]
				req.URL.Scheme = target.Scheme
				req.URL.Host = target.Host
				req.URL.Path = nextReq
			}
		}
	}
	return &httputil.ReverseProxy{Director: director}
}
