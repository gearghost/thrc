package uploader

import (
	"errors"
	"io"
	"path"
	"strings"
	"thrc/infra/minio"
	"thrc/tools/uuid"
)

func UploadAvatar(file io.Reader, filename string) (string, error) {
	minioClient, err := minio.NewMinioCli()
	if err != nil {
		return "", err
	}
	contentType, isPhoto := getPhotoType(filename)
	if isPhoto == false {
		return "", errors.New("file ext is not photo")
	}
	newFileName := uuid.Generate() + path.Ext(filename)
	info, err := minioClient.Upload(file, newFileName, "avatar", contentType)
	if err != nil {
		return "", err
	}
	return info.Location, nil
}

func getPhotoType(fileName string) (string, bool) {
	fileExt := path.Ext(fileName)
	if !strings.EqualFold(fileExt, ".png") && (!strings.EqualFold(fileExt, ".jpg")) && (!strings.EqualFold(fileExt, ".gif")) && (!strings.EqualFold(fileExt, ".bmp")) && (!strings.EqualFold(fileExt, ".jpeg")) {
		return "", false
	}
	var contentType string
	if fileExt == ".png" {
		contentType = "image/png"
	} else if fileExt == ".jpg" || fileExt == "jpeg" {
		contentType = "image/jpeg"
	} else if fileExt == ".gif" {
		contentType = "image/gif"
	} else if fileExt == ".bmp" {
		contentType = "application/x-bmp"
	}
	return contentType, true
}
