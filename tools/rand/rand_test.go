package rand

import (
	"testing"
)

func TestGenRandNum(t *testing.T) {
	result := GenerateRandNum(10)
	t.Log(result)
}
