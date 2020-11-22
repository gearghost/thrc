package server

import (
	"context"
	"testing"
	"thrc/service/user/service/grpc/proto/user"
)

/*func TestCreateUser(t *testing.T) {
	server := &Server{}
	resp, err := server.CreateUser(context.TODO(), &user.UserReq{
		UserID:   "0123456789",
		Name:     "Suika",
		Mobile:   "13900000000",
		Email:    "denzelalex@gmail.com",
		Sex:      "F",
		Birthday: "2000-01-01",
		Remark:   "user server test"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}*/

func TestGetUserByUID(t *testing.T) {
	server := &Server{}
	resp, err := server.GetUserByUID(context.TODO(), &user.UserReq{
		UserID: "3024508217"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestGetUserByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.GetUserByMobile(context.TODO(), &user.UserReq{
		Mobile: "13923772048"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdateUserByUID(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdateUserByUID(context.TODO(), &user.UserReq{
		Remark: "user server test 2",
		UserID: "0123456789"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdateUserByMobile(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdateUserByMobile(context.TODO(), &user.UserReq{
		Remark: "user server test 3",
		Mobile: "13900000000"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdateUserByEmail(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdateUserByEmail(context.TODO(), &user.UserReq{
		Remark: "user server test 4",
		Email:  "denzelalex@gmail.com"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}

func TestUpdateAvatarByUID(t *testing.T) {
	server := &Server{}
	resp, err := server.UpdateAvatarByUID(context.TODO(), &user.UserReq{
		AvatarURL: "http://guu.hk",
		UserID:    "0123456789"})
	if err != nil {
		t.Error(err)
	}
	t.Log("Response:", resp)
}
