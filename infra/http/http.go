package http

import (
	"context"
	"log"
	"net/http"
	"thrc/infra/jaeger"
	"time"

	"github.com/opentracing/opentracing-go"
	"io"
)

var (
	tracer   opentracing.Tracer
	reporter io.Closer
)

func init() {
	tr, r, err := jaeger.GetTracer("Account API Gateway")
	if err != nil {
		log.Fatal(err)
	}
	tracer = tr
	reporter = r
	opentracing.SetGlobalTracer(tracer)
}

type Http struct {
	server *http.Server
	router *Router
}

type PathGroup struct {
	Path   string
	router *Router
}

type Handler func(context.Context, http.ResponseWriter, *http.Request)

type Filter func(context.Context, http.ResponseWriter, *http.Request) bool

type Router struct {
	mux        map[string]func(context.Context, http.ResponseWriter, *http.Request)
	preFilters map[string][]Filter
}

func (r *Router) ServeHTTP(resp http.ResponseWriter, req *http.Request) {
	if f, ok := r.mux[req.URL.Path]; ok {
		span := tracer.StartSpan("API Gateway Trace")
		span.SetTag("trace to ", "API Gateway")
		defer span.Finish()
		ctx := opentracing.ContextWithSpan(context.Background(), span)
		reqSpan, _ := opentracing.StartSpanFromContext(ctx, req.URL.Path)
		defer reqSpan.Finish()

		preFilters, isPreFilterExist := r.preFilters[req.URL.Path]
		if isPreFilterExist == true {
			for _, pre := range preFilters {
				isOk := pre(ctx, resp, req)
				if isOk == false {
					return
				}
			}
		}
		f(ctx, resp, req)
		return
	}
	http.Error(resp, "error url:"+req.URL.String(), http.StatusBadRequest)
}

func (h *Http) Init(port string) {

	h.router = &Router{
		mux:        make(map[string]func(context.Context, http.ResponseWriter, *http.Request)),
		preFilters: make(map[string][]Filter),
	}

	h.server = &http.Server{
		Addr:        ":" + port,
		Handler:     h.router,
		ReadTimeout: 5 * time.Second}
	go func() {
		log.Println("http server listen to: ", h.server.Addr)
		err := h.server.ListenAndServe()
		if err != nil {
			log.Fatal(err)
		}
		defer reporter.Close()
	}()
}

func (h *Http) Post(path string, handler Handler, pre Filter) {
	h.router.mux[path] = handler
	if pre != nil {
		filters := []Filter{pre}
		h.router.preFilters[path] = filters
	}
}

func (h *Http) Get(path string, handler Handler, pre Filter) {
	h.router.mux[path] = handler
	if pre != nil {
		filters := []Filter{pre}
		h.router.preFilters[path] = filters
	}
}

func (h *Http) Group(path string, handler Handler, pre Filter) *PathGroup {
	h.router.mux[path] = handler
	g := &PathGroup{Path: path, router: h.router}
	return g
}

func (g *PathGroup) Post(path string, handler Handler, pre Filter) {
	p := g.Path + path
	g.router.mux[p] = handler
	if pre != nil {
		filters := []Filter{pre}
		g.router.preFilters[p] = filters
	}
}

func (g *PathGroup) Get(path string, handler Handler, pre Filter) {
	p := g.Path + path
	g.router.mux[p] = handler
	if pre != nil {
		filters := []Filter{pre}
		g.router.preFilters[p] = filters
	}
}

func (h *Http) AddPreFilter(path string, filter Filter) {
	filters, ok := h.router.preFilters[path]
	if ok == false {
		return
	}
	filters = append(filters, filter)
	h.router.preFilters[path] = filters
}
