package apollo

import (
	"errors"
	"fmt"
	"sync"

	"github.com/zouyx/agollo/v4"
	"github.com/zouyx/agollo/v4/agcache"
	"github.com/zouyx/agollo/v4/env/config"
	"github.com/zouyx/agollo/v4/storage"
)

type AppConfig struct {
	AppID     string
	Cluster   string
	IP        string
	Namespace string
	IsBackup  bool
	Secret    string
}

type ApolloClient struct {
	cli   *agollo.Client
	cache agcache.CacheInterface
}

func NewApolloClient(namespace string, appid string, secret string) *ApolloClient {
	c := &config.AppConfig{
		AppID:   appid,
		Cluster: "default",
		IP:      "http://localhost:8080",
		//IP:             "http://host.minikube.internal:8080",
		NamespaceName:  namespace,
		IsBackupConfig: false,
		Secret:         secret}
	agollo.SetCache(&DefaultCacheFactory{})
	agollo.SetLogger(&DefaultLogger{})
	client, err := agollo.StartWithConfig(func() (*config.AppConfig, error) {
		return c, nil
	})
	if err != nil {
		fmt.Println("err:", err)
		panic(err)
	}
	return &ApolloClient{
		cli:   client,
		cache: client.GetConfigCache(namespace)}
}

func (apc *ApolloClient) AddChangeListener(listener storage.ChangeListener) {
	apc.cli.AddChangeListener(listener)
}

func (apc *ApolloClient) Get(key string) interface{} {
	value, err := apc.cache.Get(key)
	if err != nil {
		fmt.Println("err:", err)
		return nil
	}
	return value
}

func (apc *ApolloClient) Set(key string, value interface{}, expireSeconds int) error {
	return apc.cache.Set(key, value, expireSeconds)
}

func (apc *ApolloClient) EntryCount() int64 {
	return apc.cache.EntryCount()
}

func (apc *ApolloClient) Range(f func(key, value interface{}) bool) {
	apc.cache.Range(f)
}

func (apc *ApolloClient) Del(key string) bool {
	return apc.cache.Del(key)
}

func (apc *ApolloClient) Clear() {
	apc.cache.Clear()
}

type DefaultChangeListener struct {
}

func (ccl *DefaultChangeListener) OnChange(changeEvent *storage.ChangeEvent) {
	fmt.Println("OnChange: ", changeEvent.Changes)
	for key, value := range changeEvent.Changes {
		fmt.Println("change key: ", key, ",value: ", value)
	}
}

func (ccl *DefaultChangeListener) OnNewestChange(fullChangeEvent *storage.FullChangeEvent) {
	fmt.Println("OnNewestChange: ", fullChangeEvent.Changes)
}

func checkKey(namespace string, client *agollo.Client) {
	cache := client.GetConfigCache(namespace)
	count := 0
	cache.Range(func(key, value interface{}) bool {
		fmt.Println("key: ", key, ", vaule: ", value)
		count++
		return true
	})
	if count < 1 {
		panic("config key can not be nil")
	}
}

type DefaultCache struct {
	defaultCache sync.Map
}

func (d *DefaultCache) EntryCount() (entryCount int64) {
	count := int64(0)
	d.defaultCache.Range(func(key, value interface{}) bool {
		count++
		return true
	})
	return count
}

func (d *DefaultCache) Set(key string, value interface{}, expireSeconds int) (err error) {
	d.defaultCache.Store(key, value)
	return nil
}

func (d *DefaultCache) Get(key string) (value interface{}, err error) {
	v, ok := d.defaultCache.Load(key)
	if !ok {
		return nil, errors.New("load defalut cache fail")
	}
	return v.(interface{}), nil
}

func (d *DefaultCache) Range(f func(key, value interface{}) bool) {
	d.defaultCache.Range(f)
}

func (d *DefaultCache) Del(key string) (affected bool) {
	d.defaultCache.Delete(key)
	return true
}

func (d *DefaultCache) Clear() {
	d.defaultCache = sync.Map{}
}

type DefaultCacheFactory struct {
}

func (d *DefaultCacheFactory) Create() agcache.CacheInterface {
	return &DefaultCache{}
}

type DefaultLogger struct {
}

func (this *DefaultLogger) Debugf(format string, params ...interface{}) {
	this.Debug(format, params)
}

func (this *DefaultLogger) Infof(format string, params ...interface{}) {
	this.Debug(format, params)
}

func (this *DefaultLogger) Warnf(format string, params ...interface{}) {
	this.Debug(format, params)
}

func (this *DefaultLogger) Errorf(format string, params ...interface{}) {
	this.Debug(format, params)
}

func (this *DefaultLogger) Debug(v ...interface{}) {
	fmt.Println(v...)
}

func (this *DefaultLogger) Info(v ...interface{}) {
	this.Debug(v...)
}

func (this *DefaultLogger) Warn(v ...interface{}) {
	this.Debug(v...)
}

func (this *DefaultLogger) Error(v ...interface{}) {
	this.Debug(v...)
}
