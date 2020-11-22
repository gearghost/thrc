package redis

import (
	"github.com/go-redis/redis"
	"time"
)

type RedisClient struct {
	client *redis.Client
}

func NewRedisCli() *RedisClient {
	client := redis.NewClient(&redis.Options{Addr: "127.0.0.1:6379", Password: "", DB: 0})
	//client := redis.NewClient(&redis.Options{Addr: "host.minikube.internal:6379", Password: "", DB: 0})
	return &RedisClient{client: client}
}

func (r *RedisClient) Set(key string, value string) error {
	err := r.client.Set(key, value, 0).Err()
	return err
}

func (r *RedisClient) SetEx(key string, value string, expiration int) error {
	err := r.client.Set(key, value, time.Duration(expiration)*time.Second).Err()
	return err
}

func (r *RedisClient) Get(key string) (string, error) {
	val, err := r.client.Get(key).Result()
	if err != nil {
		return "", err
	}
	return val, nil
}

func (r *RedisClient) TTL(key string) (int64, error) {
	duration, err := r.client.TTL(key).Result()
	if err != nil {
		return -1, err
	}
	return int64(duration) / 1000000000, nil
}

func (r *RedisClient) Expire(key string, expiration int) (bool, error) {
	isExpire, err := r.client.Expire(key, time.Duration(expiration)*time.Second).Result()
	if err != nil {
		return false, err
	}
	return isExpire, nil
}

func (r *RedisClient) Del(key string) (int64, error) {
	result, err := r.client.Del(key).Result()
	if err != nil {
		return -1, err
	}
	return result, nil
}
