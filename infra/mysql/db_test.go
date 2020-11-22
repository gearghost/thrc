package mysql

import (
	"testing"
)

const (
	username = "root"
	password = "root"
	addr     = "localhost"
	port     = "3306"
	dbName   = "thrc"
)

func TestNewMysqlDB(t *testing.T) {
	config := &MysqlConfig{
		Username: username,
		Password: password,
		Addr:     addr,
		Port:     port,
		DBName:   dbName,
	}
	if _, err := NewMySqlDB(config); err != nil {
		t.Error(err)
	}
}
