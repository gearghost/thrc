package md5

import (
	m "crypto/md5"
	"encoding/hex"
)

func Encrypt(key string) string {
	m5 := m.New()
	m5.Write([]byte(key))
	result := m5.Sum(nil)
	return hex.EncodeToString(result)
}

func EncryptWithSalt(key string, salt string) string {
	m5 := m.New()
	m5.Write([]byte(key))
	m5.Write([]byte(salt))
	result := m5.Sum(nil)
	return hex.EncodeToString(result)
}
