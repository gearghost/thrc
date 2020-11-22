package discovery

import (
	"go.etcd.io/etcd/clientv3"
	"testing"
)

func TestNewEtcd(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}

func TestKeep(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	err = e.Keep("Hello", "Etcd")
	if err != nil {
		t.Error(err)
	}
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}

func TestGet(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	val, err := e.Get("Hello")
	if err != nil {
		t.Error(err)
	}
	t.Log("Value: ", val)
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}

func TestDel(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	err = e.Del("hello", false)
	if err != nil {
		t.Error(err)
	}
	err = e.Keep("/1/2/3", "4")
	if err != nil {
		t.Error(err)
	}
	err = e.Del("/1", true)
	if err != nil {
		t.Error(err)
	}
	val, err := e.Get("/1/2/3")
	if err != nil {
		t.Error(err)
	}
	t.Log("Prefix:", val)
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}

func TestWatch(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	err = e.Keep("/22/33", "haha")
	if err != nil {
		t.Error(err)
	}
	err = e.Watch("/22/33", func(ch clientv3.WatchChan) {
		go func(clientv3.WatchChan) {
			for {
				select {
				case msg := <-ch:
					for _, ev := range msg.Events {
						t.Logf("Receive: %s %q: %q\n", ev.Type, ev.Kv.Key, ev.Kv.Value)
					}
				}
			}
		}(ch)
	}, true)
	err = e.Update("/22/33", "wow")
	if err != nil {
		t.Error(err)
	}
	err = e.Update("/22/33", "wocao")
	if err != nil {
		t.Error(err)
	}
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}

func TestGetByPrefix(t *testing.T) {
	e, err := NewEtcd([]string{"127.0.0.1:2379"})
	if err != nil {
		t.Error(err)
	}
	err = e.Keep("/22/33", "wakaka")
	if err != nil {
		t.Error(err)
	}
	err = e.Keep("/22/44", "wuhu")
	if err != nil {
		t.Error(err)
	}

	val, err := e.GetByPrefix("/22")
	if err != nil {
		t.Error(err)
	}
	t.Log("GetByPrefix:", val)
	err = e.Close()
	if err != nil {
		t.Error(err)
	}
}
