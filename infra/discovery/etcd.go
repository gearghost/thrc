package discovery

import (
	"context"
	"errors"
	"go.etcd.io/etcd/clientv3"
	"log"
	"sync"
	"time"
)

const (
	defalutDialTimeout      = 5 * time.Second
	defaultGrantTimeout     = 5
	defaultOperationTimeout = 5 * time.Second
)

type WatchCallback func(clientv3.WatchChan)

type Etcd struct {
	client        *clientv3.Client
	liveKeyID     map[string]clientv3.LeaseID
	liveKeyIDLock sync.RWMutex
	stop          bool
}

func NewEtcd(endpoints []string) (*Etcd, error) {
	cli, err := clientv3.New(clientv3.Config{
		Endpoints:   endpoints,
		DialTimeout: defalutDialTimeout,
	})
	if err != nil {
		log.Printf("NewEtcd err=%v", err)
		return nil, err
	}
	return &Etcd{
		client:    cli,
		liveKeyID: make(map[string]clientv3.LeaseID),
		stop:      false,
	}, nil

}

func (e *Etcd) Keep(key, value string) error {
	resp, err := e.client.Grant(context.TODO(), defaultGrantTimeout)
	if err != nil {
		log.Printf("Etcd.keep Grant %s %v", key, err)
		return err
	}
	_, err = e.client.Put(context.TODO(), key, value, clientv3.WithLease(resp.ID))
	if err != nil {
		log.Printf("Etcd.keep Put %s %v", key, err)
		return err
	}
	ch, err := e.client.KeepAlive(context.TODO(), resp.ID)
	if err != nil {
		log.Printf("Etcd.keep %s %v", key, err)
		return err
	}
	go func() {
		for {
			if e.stop {
				return
			}
			<-ch
			time.Sleep(100 * time.Millisecond)
		}
	}()
	e.liveKeyIDLock.Lock()
	e.liveKeyID[key] = resp.ID
	e.liveKeyIDLock.Unlock()
	//log.Infof("Etcd.keep %s %v %v", key, value, err)
	return nil
}

func (e *Etcd) Del(key string, prefix bool) error {
	e.liveKeyIDLock.Lock()
	delete(e.liveKeyID, key)
	e.liveKeyIDLock.Unlock()
	var err error
	if prefix {
		_, err = e.client.Delete(context.TODO(), key, clientv3.WithPrefix())
	} else {
		_, err = e.client.Delete(context.TODO(), key)
	}
	return err
}

func (e *Etcd) Watch(key string, watchFunc WatchCallback, prefix bool) error {
	if watchFunc == nil {
		return errors.New("watchFunc is nil")
	}

	if prefix {
		watchFunc(e.client.Watch(context.Background(), key, clientv3.WithPrefix()))
	} else {
		watchFunc(e.client.Watch(context.Background(), key))
	}
	return nil
}

func (e *Etcd) Close() error {
	if e.stop {
		return errors.New("Etcd is already closed")
	}
	e.stop = true
	e.liveKeyIDLock.Lock()
	for k, _ := range e.liveKeyID {
		e.client.Delete(context.TODO(), k)
	}
	e.liveKeyIDLock.Unlock()
	return e.client.Close()
}

func (e *Etcd) Get(key string) (string, error) {
	ctx, cancel := context.WithTimeout(context.Background(), defaultOperationTimeout)
	resp, err := e.client.Get(ctx, key)
	if err != nil {
		cancel()
		return "", err
	}
	var val string
	for _, ev := range resp.Kvs {
		val = string(ev.Value)
	}
	cancel()
	return val, err
}

func (e *Etcd) GetByPrefix(key string) (map[string]string, error) {
	ctx, cancel := context.WithTimeout(context.Background(), defaultOperationTimeout)
	resp, err := e.client.Get(ctx, key, clientv3.WithPrefix())
	if err != nil {
		cancel()
		return nil, err
	}
	m := make(map[string]string)
	for _, kv := range resp.Kvs {
		m[string(kv.Key)] = string(kv.Value)
	}
	cancel()
	return m, err
}

func (e *Etcd) Update(key, value string) error {
	e.liveKeyIDLock.Lock()
	id := e.liveKeyID[key]
	e.liveKeyIDLock.Unlock()
	_, err := e.client.Put(context.TODO(), key, value, clientv3.WithLease(id))
	if err != nil {
		err = e.Keep(key, value)
		if err != nil {
			log.Printf("Etcd.Keep %s %s %v", key, value, err)
		}
	}
	return err
}
