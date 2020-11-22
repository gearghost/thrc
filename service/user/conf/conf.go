package conf

import (
	"thrc/infra/apollo"
	"thrc/infra/discovery"
	"thrc/infra/mysql"
	"thrc/tools/net"
	"thrc/tools/rand"

	"github.com/zouyx/agollo/v4/storage"
)

const (
	grpcScheme = "grpc://"
)

var (
	config *apollo.ApolloClient
)

func init() {
	config = apollo.NewApolloClient("application", "thrc-user", "849e0d809f4f47f9a1b35f16e12d76e1")
}

func WatchDBChanged(h Handler) {
	dbConfigListener := &DBConfigListener{}
	dbConfigListener.AddChangeHandler(h)
	config.AddChangeListener(dbConfigListener)
}

func GetSrvPort() string {
	return config.Get("port").(string)
}

func GetNodeInfo() *discovery.NodeInfo {
	port := config.Get("port").(string)
	region := config.Get("region").(string)
	zone := config.Get("zone").(string)
	env := config.Get("env").(string)
	appid := config.Get("appid").(string)
	addr := grpcScheme + net.LocalIP() + ":" + port
	return &discovery.NodeInfo{
		Region:   region,
		Zone:     zone,
		Env:      env,
		AppID:    appid,
		Hostname: rand.GenerateRandNum(6),
		Addrs:    []string{addr},
	}
}

func GetDBConfig() *mysql.MysqlConfig {
	//mysql config
	mysql_username := config.Get("mysql-username").(string)
	mysql_password := config.Get("mysql-password").(string)
	mysql_addr := config.Get("mysql-addr").(string)
	mysql_port := config.Get("mysql-port").(string)
	mysql_db := config.Get("mysql-db").(string)
	return &mysql.MysqlConfig{
		Username: mysql_username,
		Password: mysql_password,
		Addr:     mysql_addr,
		Port:     mysql_port,
		DBName:   mysql_db}
}

type Handler func(string, interface{})

type DBConfigListener struct {
	handler Handler
}

func (listener *DBConfigListener) OnChange(changeEvent *storage.ChangeEvent) {
	for k, v := range changeEvent.Changes {
		listener.handler(k, v)
	}
}

func (listener *DBConfigListener) OnNewestChange(fullChangeEvent *storage.FullChangeEvent) {
}

func (listener *DBConfigListener) AddChangeHandler(h Handler) {
	listener.handler = h
}
