package model

import (
	"time"
)

type Account struct {
	Id         string    `json:"id,omitempty"`
	UserId     string    `json:"user_id,omitempty"`
	Mobile     string    `json:"mobile,omitempty"`
	Email      string    `json:"email,omitempty"`
	Salt       string    `json:"salt,omitempty"`
	Password   string    `json:"password,omitempty"`
	Remark     string    `json:"remark,omitempty"`
	CreateTime time.Time `json:"create_time,omitempty"`
	UpdateTime time.Time `json:"update_time,omitempty"`
}
