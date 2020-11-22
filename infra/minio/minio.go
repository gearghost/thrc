package minio

import (
	"context"
	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
	"io"
)

type MinioCli struct {
	client *minio.Client
}

var (
	endpoint        = "8.129.221.40:9000"
	accessKeyID     = "minioadmin"
	secretAccessKey = "minioadmin"
	useSSL          = false
)

func NewMinioCli() (*MinioCli, error) {
	minioClient, err := minio.New(endpoint, &minio.Options{
		Creds:  credentials.NewStaticV4(accessKeyID, secretAccessKey, ""),
		Secure: useSSL,
	})
	if err != nil {
		return nil, err
	}
	return &MinioCli{client: minioClient}, nil
}

func (mc *MinioCli) Upload(file io.Reader, filename string, bucket string, contentType string) (*minio.UploadInfo, error) {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	n, err := mc.client.PutObject(ctx, bucket, filename, file, -1, minio.PutObjectOptions{ContentType: contentType})
	if err != nil {
		return nil, err
	}
	return &n, nil
}
