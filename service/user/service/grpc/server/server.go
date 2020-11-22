package server

import (
	"context"
	"database/sql"
	"encoding/json"
	"thrc/service/user/dao"
	"thrc/service/user/model"
	"thrc/service/user/service/grpc/proto/user"
)

type Server struct {
	userDAO *dao.UserDAO
}

func New(db *sql.DB) *Server {
	dao := dao.NewUserDAO(db)
	return &Server{userDAO: dao}
}

func (s *Server) Reload(db *sql.DB) {
	s.userDAO = dao.NewUserDAO(db)
}

func (s *Server) CreateUser(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	_, err := s.userDAO.CreateUser(&model.User{UserId: in.UserID,
		Name:     in.Name,
		Mobile:   in.Mobile,
		Email:    in.Email,
		Sex:      in.Sex,
		Birthday: in.Birthday,
		Remark:   in.Remark})
	if err != nil {
		return newResp(-1, "create user fail", ""), err
	}
	return newResp(1000, "create user success", ""), nil
}

func (s *Server) GetUserByUID(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	u, err := s.userDAO.GetUserByUID(in.UserID)
	if err != nil {
		return newResp(-1, "get user by uid from database", ""), err
	}
	data, err := json.Marshal(u)
	if err != nil {
		return newResp(-1, "user json marshal fail", ""), err
	}
	return newResp(1000, "get user info by uid success", string(data)), nil
}

func (s *Server) GetUserByMobile(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	u, err := s.userDAO.GetUserByMobile(in.Mobile)
	if err != nil {
		return newResp(-1, "get user by mobile from database", ""), err
	}
	data, err := json.Marshal(u)
	if err != nil {
		return newResp(-1, "user json marshal fail", ""), err
	}
	return newResp(1000, "get user info by mobile", string(data)), nil
}

func (s *Server) UpdateUserByUID(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	_, err := s.userDAO.UpdateUserByUID(&model.User{Name: in.Name,
		Mobile:   in.Mobile,
		Email:    in.Email,
		Sex:      in.Sex,
		Birthday: in.Birthday,
		Remark:   in.Remark}, in.UserID)
	if err != nil {
		return newResp(-1, "update user into database fail", ""), err
	}
	return newResp(1000, "update user success", ""), nil
}

func (s *Server) UpdateUserByMobile(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	_, err := s.userDAO.UpdateUserByMobile(&model.User{Name: in.Name,
		Mobile:   in.Mobile,
		Email:    in.Email,
		Sex:      in.Sex,
		Birthday: in.Birthday,
		Remark:   in.Remark}, in.Mobile)
	if err != nil {
		return newResp(-1, "update user into database fail", ""), err
	}
	return newResp(1000, "update user success", ""), nil
}

func (s *Server) UpdateUserByEmail(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	_, err := s.userDAO.UpdateUserByEmail(&model.User{Name: in.Name,
		Mobile:   in.Mobile,
		Email:    in.Email,
		Sex:      in.Sex,
		Birthday: in.Birthday,
		Remark:   in.Remark}, in.Email)
	if err != nil {
		return newResp(-1, "update user into database fail", ""), err
	}
	return newResp(1000, "update user success", ""), nil
}

func (s *Server) UpdateAvatarByUID(ctx context.Context, in *user.UserReq) (*user.UserResp, error) {
	_, err := s.userDAO.UpdateAvatarByUID(in.AvatarURL, in.UserID)
	if err != nil {
		return newResp(-1, "update avatar into database fail", ""), err
	}
	return newResp(1000, "update avatar success", ""), nil
}

func newResp(code int32, msg string, data string) *user.UserResp {
	return &user.UserResp{Code: code, Message: msg, Data: data}
}
