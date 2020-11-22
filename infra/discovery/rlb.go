package discovery

import (
	"math/rand"
	"time"
)

type RLB struct {
}

func (r RLB) Get(count int) int {
	rand.Seed(time.Now().UnixNano())
	return rand.Intn(count)
}
