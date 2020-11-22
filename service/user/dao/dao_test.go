package dao

import (
	"testing"
	"thrc/infra/mysql"
	"thrc/service/user/model"
	"time"
)

func TestGetNewUserDAO(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
}

func TestCreateUser(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	idx, err := db.CreateUser(&model.User{
		UserId:       "1234567890",
		Name:         "Mono",
		Mobile:       "13923772048",
		Email:        "cloudeniac@gmail.com",
		Sex:          "M",
		Birthday:     "1990-01-01",
		Age:          "29",
		AvatarURL:    "http://suika.in",
		Remark:       "user dao test",
		RegisterTime: time.Now(),
		UpdateTime:   time.Now()})
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}

func TestGetUserByUID(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	u, err := db.GetUserByUID("1234567890")
	if err != nil {
		t.Error()
	}
	t.Log("User:", u)
}

func TestGetUserByMobile(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	u, err := db.GetUserByMobile("13923772048")
	if err != nil {
		t.Error()
	}
	t.Log("User:", u)
}

func TestUpdateUserByUID(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	idx, err := db.UpdateUserByUID(&model.User{Email: "r.hwang@yahoo.com.hk"},
		"1234567890")
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}

func TestUpdateUserByMobile(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	idx, err := db.UpdateUserByMobile(&model.User{Email: "cloudeniac@gmail.com"},
		"13923772048")
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}

func TestUpdateUserByEmail(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	idx, err := db.UpdateUserByMobile(&model.User{Mobile: "13912345678"},
		"cloudeniac@gmail.com")
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}

func TestUpdateAvatarByUID(t *testing.T) {
	database, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	db := NewUserDAO(database)
	if db == nil {
		t.Error()
	}
	idx, err := db.UpdateAvatarByUID("http://thrc.com", "1234567890")
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}
