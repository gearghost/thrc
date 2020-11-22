package discovery

import (
	"go.etcd.io/etcd/clientv3"
	"log"
	"sync"
)

type Client struct {
	dis      *Discovery
	cfg      *AppConfig
	appid    string
	appCache []*Node
	lb       Balancer
	lock     sync.RWMutex
}

type AppConfig struct {
	Region string `json:"region"`
	Zone   string `json:"zone"`
	Env    string `json:"env"`
}

func NewDiscoveryCli(appid string, cfg *AppConfig) *Client {
	dis, err := NewDiscovery()
	if err != nil {
		return nil
	}
	c := &Client{
		dis:      dis,
		cfg:      cfg,
		appid:    appid,
		appCache: make([]*Node, 100),
		lb:       &RLB{},
	}

	c.proccache(appid, cfg)

	//appPath := generateSearchTree(cfg.Region, cfg.Zone, cfg.Env, appid)
	//appPrefix := getMaxParentTree(appPath)

	//dis.watch(appPrefix, c.watch)
	return c
}

func (c *Client) Watch(appid string, watchFunc WatchCallback) {
	appPath := generateSearchTree(c.cfg.Region, c.cfg.Zone, c.cfg.Env, appid)
	appPrefix := getMaxParentTree(appPath)

	c.dis.watch(appPrefix, watchFunc)
}

func (c *Client) GetNode() *Node {
	c.lock.RLock()
	defer c.lock.RUnlock()
	count := len(c.appCache)
	if count == 0 {
		return nil
	}
	idx := c.lb.Get(count)
	return c.appCache[idx]
}

func (c *Client) GetNodes() []*Node {
	return c.appCache
}

func (c *Client) AddNode(node *Node) {
	c.appCache = append(c.appCache, node)
}

func (c *Client) RemoveNode(node *Node) int {
	idx := -1
	for i, v := range c.appCache {
		if v.Hostname == node.Hostname {
			idx = i
		}
	}
	if idx != -1 {
		c.appCache = append(c.appCache[:idx], c.appCache[idx+1:]...)
	}
	return idx
}

func (c *Client) proccache(appid string, cfg *AppConfig) bool {
	c.lock.Lock()
	defer c.lock.Unlock()
	appPath := generateSearchTree(cfg.Region, cfg.Zone, cfg.Env, appid)
	nodes, err := c.dis.getNodes(appPath)
	if err != nil {
		return false
	}
	c.appCache = nodes
	return true
}

func (c *Client) watch(ch clientv3.WatchChan) {
	go func(clientv3.WatchChan) {
		for {
			select {
			case msg := <-ch:
				for _, ev := range msg.Events {
					log.Printf("Receive: %s %q: %q\n", ev.Type, ev.Kv.Key, ev.Kv.Value)
					value := string(ev.Kv.Value)
					if ev.Type == 0 {
						node := GetNodeByStr(value)
						log.Println("add node: ", node.Hostname)
						searchTree := generateRegexpTree(c.cfg.Region, c.cfg.Zone,
							c.cfg.Env, c.appid)
						key := generateTree(node.Region, node.Zone, node.Env) + "/" + node.AppID
						isMatched := matchTree(key, searchTree)
						if isMatched {
							c.lock.Lock()
							c.appCache = append(c.appCache, node)
							c.lock.Unlock()
							log.Println("added node: ", node.Hostname, node.Addrs)
						}

					} else {
						node := GetNodeByStr(value)
						log.Println("delete node: ", node.Hostname)
						c.lock.Lock()
						for i, v := range c.appCache {
							if v.Hostname == node.Hostname {
								c.appCache = append(c.appCache[:i], c.appCache[i+1:]...)
								log.Println("deleted node: ", v.Hostname, v.Addrs)
							}
						}
						c.lock.Unlock()
					}
				}
			}
		}
	}(ch)
}
