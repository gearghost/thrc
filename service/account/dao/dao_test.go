package dao

import (
	"testing"
	"thrc/infra/mysql"
	"thrc/service/account/model"
	//"thrc/service/account/model"
	//"time"
)

func TestAccountDAO(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
}

/*func TestCreateAccount(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := newAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	idx, err := accountDao.CreateAccount(&model.Account{
		Id:         "123456",
		UserId:     "10000",
		Mobile:     "13923772048",
		Email:      "cloudeniac@gmail.com",
		Salt:       "111",
		Password:   "asdfghjkl",
		Remark:     "whatever",
		CreateTime: time.Now(),
		UpdateTime: time.Now()})
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}*/

func TestChectExistByMobile(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	idx, err := accountDao.CheckAccountExistByMobile("13923772048")
	if err != nil {
		t.Error(err)
	}
	t.Log("index:", idx)
}

func TestGetIdByMobile(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	id, err := accountDao.CheckAccountExistByMobile("13923772048")
	if err != nil {
		t.Error(err)
	}
	t.Log("id:", id)
}

func TestGetPasswordByMobile(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	passwd, salt, err := accountDao.GetPasswordByMobile("13923772048")
	if err != nil {
		t.Error(err)
	}
	t.Log("Password:", passwd, "Salt:", salt)
}

func TestGetPasswordById(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	passwd, salt, err := accountDao.GetPasswordById("123456")
	if err != nil {
		t.Error(err)
	}
	t.Log("Password:", passwd, "Salt:", salt)
}

func TestGetUserIdById(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	uid, err := accountDao.GetUserIdByID("123456")
	if err != nil {
		t.Error(err)
	}
	t.Log("UserID:", uid)
}

func TestGetAccountByMobile(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	account, err := accountDao.GetAccountByMobile("13923772048")
	if err != nil {
		t.Error(err)
	}
	t.Log(account.Id)
}

func TestGetAccountById(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	account, err := accountDao.GetAccountByUID("10000")
	if err != nil {
		t.Error(err)
	}
	t.Log(account.Id)
}

func TestUpdateAccountById(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	idx, err := accountDao.UpdateAccountById(&model.Account{
		Id:    "123456",
		Email: "r.hwang@yahoo.com.hk"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Index:", idx)
}

func TestUpdatePasswordById(t *testing.T) {
	db, err := mysql.NewMySqlDB()
	if err != nil {
		t.Error(err)
	}
	accountDao := NewAccountDAO(db)
	if accountDao == nil {
		t.Error()
	}
	idx, err := accountDao.UpdatePasswdById("qwertyuiop", "123456")
	if err != nil {
		t.Error(err)
	}
	t.Log("Index:", idx)
}
