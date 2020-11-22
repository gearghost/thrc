package http

import (
	"log"
	"net/http"
	"testing"
)

func TestHttpServer(t *testing.T) {
	server := new(Http)
	server.Init()
	g := server.Group("/a", testGroup, nil)
	g.Post("/b", testGroup, nil)
	g.Get("/c", testGroup, nil)
	err := server.server.ListenAndServe()
	if err != nil {
		t.Error(err)
	}
}

func testGroup(w http.ResponseWriter, r *http.Request) {
	log.Println(r)
}
