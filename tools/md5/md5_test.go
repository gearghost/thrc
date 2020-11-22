package md5

import (
	"testing"
)

func TestEncrypt(t *testing.T) {
	if encryptText := Encrypt("123456"); encryptText != "e10adc3949ba59abbe56e057f20f883e" {
		t.Error()
	}
}

func TestDecrypt(t *testing.T) {
	if encryptText := EncryptWithSalt("123456", "111"); encryptText != "490874df393be07d46b1cfdc7aa88037" {
		t.Error()
	}
}
