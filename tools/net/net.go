package net

import (
	"bytes"
	"net"
	"net/http"
	"strings"
)

func GenerateQueryString(url string, m map[string]string) string {
	return url + "?" + mapToQueryString(m)
}

func mapToQueryString(m map[string]string) string {
	buf := bytes.Buffer{}
	for k, v := range m {
		if v != "" {
			buf.WriteString(k + "=" + v + "&")
		}
	}
	return strings.TrimRight(buf.String(), "&")
}

func GetRemoteAddr(req *http.Request) (remoteAddr string) {
	remoteAddr = req.Header.Get("Remote_addr")
	if len(remoteAddr) == 0 {
		remoteAddr = strings.Split(strings.Replace(req.RemoteAddr,
			"[::1]", "127.0.0.1", 1), ":")[0]
	}
	return
}

func GetDomain(req *http.Request) string {
	scheme := req.Header.Get("x-scheme")
	if scheme == "" {
		scheme = "http"
	}
	host := req.Header.Get("Host")
	if host == "" {
		host = req.Host
	}
	return scheme + "://" + host
}

func LocalIP() string {
	info, _ := net.InterfaceAddrs()
	for _, addr := range info {
		ipNet, ok := addr.(*net.IPNet)
		if !ok {
			continue
		}
		if !ipNet.IP.IsLoopback() && ipNet.IP.To4() != nil {
			return ipNet.IP.String()
		}
	}
	return "127.0.0.1"
}
