package aes

import (
	"testing"
)

func TestEncrypt(t *testing.T) {
	key := []byte("0123456789abcdef")
	if _, err := Encrypt(key, "123456"); err != nil {
		t.Error(err)
	}
}

func TestDecrypt(t *testing.T) {
	key := []byte("0123456789abcdef")
	encryptText, err := Encrypt(key, "123456")
	if err != nil {
		t.Error(err)
	}
	t.Log("Encrypt: ", encryptText)

	rawText, err := Decrypt(key, encryptText)
	if err != nil {
		t.Error(err)
	}
	t.Log("Decrypt: ", rawText)
}
