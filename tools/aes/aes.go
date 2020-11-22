package aes

import (
	"bytes"
	a "crypto/aes"
	"crypto/cipher"
	"encoding/hex"
	"errors"
)

func pad(src []byte) []byte {
	padding := a.BlockSize - len(src)%a.BlockSize
	padtext := bytes.Repeat([]byte{byte(padding)}, padding)
	return append(src, padtext...)
}

func unpad(src []byte) ([]byte, error) {
	length := len(src)
	unpadding := int(src[length-1])
	if unpadding > length {
		return nil, errors.New("unpad error. This could happen when incorrect encryption key is used")
	}
	return src[:length-unpadding], nil
}

func Encrypt(key []byte, text string) (string, error) {
	block, err := a.NewCipher(key)
	if err != nil {
		return "", err
	}
	msg := pad([]byte(text))
	cipherText := make([]byte, a.BlockSize+len(msg))
	iv := make([]byte, a.BlockSize)
	mode := cipher.NewCBCEncrypter(block, iv)
	mode.CryptBlocks(cipherText[a.BlockSize:], msg)
	finalMsg := hex.EncodeToString([]byte(cipherText[a.BlockSize:]))
	return finalMsg, nil
}

func Decrypt(key []byte, text string) (string, error) {
	block, err := a.NewCipher(key)
	if err != nil {
		return "", err
	}
	decodeMsg, _ := hex.DecodeString(text)
	iv := make([]byte, a.BlockSize)
	msg := decodeMsg

	mode := cipher.NewCBCDecrypter(block, iv)
	mode.CryptBlocks(msg, msg)

	unpadMsg, err := unpad(msg)

	if err != nil {
		return "", err
	}
	return string(unpadMsg), nil
}
