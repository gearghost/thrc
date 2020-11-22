package discovery

type Client2 interface {
	GetClient(*Client) (interface{}, error)
	Close()
}
