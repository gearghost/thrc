package minio

import (
	"os"
	"testing"
)

func TestMinioCli(t *testing.T) {
	_, err := NewMinioCli()
	if err != nil {
		t.Error(err)
	}
}

func TestUpload(t *testing.T) {
	mc, err := NewMinioCli()
	if err != nil {
		t.Error(err)
	}
	file, err := os.Open("test.jpg")
	if err != nil {
		t.Error(err)
	}
	defer file.Close()
	uploadinfo, err := mc.Upload(file, "test.jpg", "avatar", "image/jpg")
	if err != nil {
		t.Error(err)
	}
	t.Log(uploadinfo.Location)
}
