package model

import (
	"time"
)

type User struct {
	UserId       string    `json:"user_id,omitempty"`
	Name         string    `json:"name,omitempty"`
	Mobile       string    `json:"mobile,omitempty"`
	Email        string    `json:"email,omitempty"`
	Sex          string    `json:"sex,omitempty"`
	Birthday     string    `json:"birthday,omitempty"`
	Age          string    `json:"age,omitempty"`
	AvatarURL    string    `json:"avatar_url,omitempty"`
	Remark       string    `json:"remark,omitempty"`
	RegisterTime time.Time `json:"register_time,omitempty"`
	UpdateTime   time.Time `json:"update_time,omitempty"`
}
