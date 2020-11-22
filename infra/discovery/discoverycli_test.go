package discovery

import (
	"testing"
)

func TestDiscoveryCli(t *testing.T) {
	cfg := &AppConfig{
		Region: "cn",
		Zone:   "gd",
		Env:    "dev",
	}
	disCli := NewDiscoveryCli("thrc.account", cfg)
	if disCli == nil {
		t.Error("create discovery client fail")
	}
	node := disCli.GetNode()
	if node != nil {
		t.Log("Node addr:", node.Addrs)
	}
	select {}
}
