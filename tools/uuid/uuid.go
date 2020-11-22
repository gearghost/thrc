package uuid

import (
	"encoding/hex"
	u "github.com/gofrs/uuid"
)

func Generate() string {
	b := u.Must(u.NewV4()).Bytes()
	buf := make([]byte, 32)
	hex.Encode(buf[:], b[:])
	return string(buf)
}

func GenCanonical() string {
	return u.Must(u.NewV4()).String()
}
