package http

import (
	"context"
	"log"
	"net/http"
	"testing"
)

func TestHttpServer(t *testing.T) {
	server := Http{}
	server.Init("10010")
	g := server.Group("/a", testGroup, nil)
	g.Post("/b", testGroup, nil)
	g.Get("/c", testGroup, nil)
	select {}
}

func testGroup(c context.Context, w http.ResponseWriter, r *http.Request) {
	log.Println(r)
}
