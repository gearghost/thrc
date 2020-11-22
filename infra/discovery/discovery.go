package discovery

import (
	"encoding/json"
	"errors"
	"regexp"
	"strings"
	"time"
)

type Node struct {
	Region   string   `json:"region"`
	Zone     string   `json:"zone"`
	Env      string   `json:"env"`
	AppID    string   `json:"app_id"`
	Hostname string   `json:"hostname"`
	Version  string   `json:"version"`
	Metadata Metadata `json:"metadata"`
	Status   int      `json:"status"`
	Addrs    []string `json:"addrs"`
	RegTime  int64    `json:"reg_timestamp"`
	UpTime   int64    `json:"up_timestamp"`
}

type NodeInfo struct {
	Region   string
	Zone     string
	Env      string
	AppID    string
	Hostname string
	Addrs    []string
	Version  string
	Provider string
	Weight   string
}

type Metadata struct {
	Provider string `json:"provider"`
	Weight   string `json:"weight"`
}

type Discovery struct {
	etcd *Etcd
}

func NewDiscovery() (*Discovery, error) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	//e, err := NewEtcd([]string{"host.minikube.internal:2379"})
	if err != nil {
		return nil, err
	}
	return &Discovery{etcd: e}, nil
}

func (d *Discovery) Register(nodeinfo *NodeInfo) error {
	AppPath := generateTree(nodeinfo.Region, nodeinfo.Zone, nodeinfo.Env) +
		"/" + nodeinfo.AppID + "/" + nodeinfo.Hostname
	now := time.Now().UnixNano()
	node := &Node{
		Region:   nodeinfo.Region,
		Zone:     nodeinfo.Zone,
		Env:      nodeinfo.Env,
		AppID:    nodeinfo.AppID,
		Hostname: nodeinfo.Hostname,
		Version:  nodeinfo.Version,
		Metadata: Metadata{
			Provider: nodeinfo.Provider,
			Weight:   nodeinfo.Weight,
		},
		Status:  1,
		Addrs:   nodeinfo.Addrs,
		RegTime: now,
		UpTime:  now,
	}
	str, _ := json.Marshal(node)
	err := d.etcd.Keep(AppPath, string(str))
	if err != nil {
		return err
	}
	return nil
}

func (d *Discovery) Unregister(node *NodeInfo) error {
	AppPath := generateTree(node.Region, node.Zone, node.Env) +
		"/" + node.AppID + "/" + node.Hostname
	err := d.etcd.Del(AppPath, false)
	if err != nil {
		return err
	}
	return nil
}

func (d *Discovery) watch(appPath string, watchFunc WatchCallback) error {
	if watchFunc == nil {
		return errors.New("watchFunc is nil")
	}
	if appPath != "" {
		err := d.etcd.Watch(appPath, watchFunc, true)
		if err != nil {
			return err
		}
	} else {
		return errors.New("appPath is empty")
	}
	return nil
}

func (d *Discovery) getNodes(appPath string) ([]*Node, error) {
	appPath = appPath + "/*"
	var result []*Node
	appPrefix := getMaxParentTree(appPath)
	regtext := strings.Replace(appPath, "*", "\\w*", -1)
	nodes, err := d.etcd.GetByPrefix(appPrefix)
	if err != nil {
		return nil, err
	}
	for k, v := range nodes {
		matched := matchTree(k, regtext)
		if err != nil {
			continue
		}
		if matched {
			node := GetNodeByStr(v)
			result = append(result, node)
		}
	}
	return result, nil
}

func GetNodeByStr(nodestr string) *Node {
	var node Node
	err := json.Unmarshal([]byte(nodestr), &node)
	if err != nil {
		return nil
	}
	return &node
}

func generateTree(region, zone, env string) string {
	return "/" + region + "/" + zone + "/" + env
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

func generateRegexpTree(region, zone, env, appid string) string {
	appPath := generateSearchTree(region, zone, env, appid)
	regtext := strings.Replace(appPath, "*", "\\w*", -1)
	return regtext
}

func matchTree(tree, matchtree string) bool {
	matched, err := regexp.MatchString(matchtree, tree)
	if err != nil {
		return false
	}
	return matched
}

func getMaxParentTree(tree string) string {
	return strings.Split(tree, "*")[0]
}

func getHostname(tree string) string {
	return strings.Split(tree, "/")[5]
}
