package uuid

import (
	"testing"
)

func Test_Generate(t *testing.T) {
	u := Generate()
	t.Log("Generate: ", u)
}

func Test_GenerateCanonical(t *testing.T) {
	u := GenCanonical()
	t.Log("GenCanonical: ", u)
}
