package redis

import (
	"testing"
	"time"
)

func TestNewCli(t *testing.T) {
	//actually this is alway return not nil
	if cli := NewRedisCli(); cli == nil {
		t.Error("Error")
	}
}

func TestSetAndGet(t *testing.T) {
	cli := NewRedisCli()
	cli.Set("Hello", "Redis")
	result, err := cli.Get("Hello")
	if err != nil {
		t.Error(err)
	}
	t.Log("Get: ", result)
}

func TestSetEx(t *testing.T) {
	cli := NewRedisCli()
	err := cli.SetEx("Hello", "TestSetEx", 2)
	if err != nil {
		t.Error(err)
	}
	result, err := cli.Get("Hello")
	if result != "TestSetEx" {
		t.Error()
	}
	t.Log("Get: ", result)
	time.Sleep(3 * time.Second)
	if _, err := cli.Get("Hello"); err == nil {
		t.Error(err)
	}
}

func TestTTL(t *testing.T) {
	cli := NewRedisCli()
	err := cli.SetEx("Hello", "Test", 3)
	if err != nil {
		t.Error(err)
	}
	ttl, err := cli.TTL("Hello")
	if err != nil {
		t.Error(err)
	}
	t.Log("TTL: ", ttl)
}

func TestExpire(t *testing.T) {
	cli := NewRedisCli()
	err := cli.Set("Hello", "Test")
	if err != nil {
		t.Error(err)
	}
	result, err := cli.Expire("Hello", 5)
	if err != nil {
		t.Error(err)
	}
	t.Log("Expire: ", result)
}

func TestDel(t *testing.T) {
	cli := NewRedisCli()
	err := cli.Set("Hello", "Test")
	if err != nil {
		t.Error(err)
	}
	result, err := cli.Del("Hello")
	if err != nil {
		t.Error(err)
	}
	t.Log("Del: ", result)
}
