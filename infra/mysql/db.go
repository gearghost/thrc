package mysql

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"strings"
)

type MysqlConfig struct {
	Username string
	Password string
	Addr     string
	Port     string
	DBName   string
}

func NewMySqlDB(cfg *MysqlConfig) (*sql.DB, error) {
	dsn := strings.Join([]string{cfg.Username, ":", cfg.Password, "@tcp(", cfg.Addr, ":", cfg.Port, ")/", cfg.DBName, "?charset=utf8&parseTime=True&loc=Local"}, "")
	db, err := sql.Open("mysql", dsn)
	db.SetConnMaxLifetime(100)
	db.SetMaxIdleConns(10)
	db.SetMaxIdleConns(10)
	if err := db.Ping(); err != nil {
		return nil, err
	}
	return db, err
}
