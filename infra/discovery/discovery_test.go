package discovery

import (
	"testing"
)

func TestDiscovery(t *testing.T) {
	_, err := NewDiscovery()
	if err != nil {
		t.Error(err)
	}
}

func TestRegister(t *testing.T) {
	d, err := NewDiscovery()
	if err != nil {
		t.Error(err)
	}
	err = d.Register(&NodeInfo{
		Region:   "cn",
		Zone:     "gd",
		Env:      "dev",
		AppID:    "thrc.test",
		Hostname: "123456",
		Addrs:    []string{"127.0.0.1:9090"}})
	if err != nil {
		t.Error(err)
	}
}
