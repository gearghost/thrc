package model

type Password struct {
	Passwd string `json:"password,omitempty"`
	Salt   string `json:"salt,omitempty"`
}
