package rand

import (
	"fmt"
	r "math/rand"
	"strings"
	"time"
)

func GenerateRandNum(width int) string {
	numeric := [10]byte{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	l := len(numeric)
	r.Seed(time.Now().UnixNano())
	var sb strings.Builder
	for i := 0; i < width; i++ {
		fmt.Fprintf(&sb, "%d", numeric[r.Intn(l)])
	}
	return sb.String()
}
