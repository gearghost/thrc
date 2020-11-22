package server

import (
	"context"
	"testing"
	"thrc/service/account/service/grpc/proto/account"
)

/*func TestCreateAccount(t *testing.T) {
	server := &Server{}
	resp, err := server.CreateAccount(context.TODO(), &account.AccountReq{Mobile: "13923772048",
		Email:    "cloudeniac@gmail.com",
		Password: "123456789",
		Remark:   "server test"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}*/

func TestCheckExistByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.CheckAccountExistByMobile(context.TODO(),
		&account.AccountReq{Mobile: "13923772048"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetIdByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.GetIdByMobile(context.TODO(), &account.AccountReq{
		Mobile: "13923772048"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetPasswordByID(t *testing.T) {
	server := &Server{}
	resp, err := server.GetPasswordById(context.TODO(), &account.AccountReq{
		ID: "39959c0e645f454fbca3bf2cc6f77c22"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetPasswordByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.GetPasswordByMobile(context.TODO(),
		&account.AccountReq{Mobile: "13923772048"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetUserIdByID(t *testing.T) {
	server := &Server{}
	resp, err := server.GetUserIdByID(context.TODO(),
		&account.AccountReq{ID: "39959c0e645f454fbca3bf2cc6f77c22"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetAccountByUID(t *testing.T) {
	server := &Server{}
	resp, err := server.GetAccountByUID(context.TODO(),
		&account.AccountReq{UserID: "9761441873"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetAccountByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.GetAccountByMobile(context.TODO(),
		&account.AccountReq{Mobile: "13923772048"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdateAccountByID(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdateAccountById(context.TODO(),
		&account.AccountReq{ID: "39959c0e645f454fbca3bf2cc6f77c22",
			Email: "r.hwang@yahoo.com.hk"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdatePasswordByID(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdatePasswdById(context.TODO(),
		&account.AccountReq{ID: "39959c0e645f454fbca3bf2cc6f77c22",
			Password: "111111111"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}
