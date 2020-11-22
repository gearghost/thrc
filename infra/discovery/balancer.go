package discovery

type Balancer interface {
	Get(int) int
}
