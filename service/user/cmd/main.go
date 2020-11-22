package main

import (
	"github.com/grpc-ecosystem/go-grpc-middleware/tracing/opentracing"
	"google.golang.org/grpc"
	"log"
	"net"
	"thrc/infra/discovery"
	"thrc/infra/jaeger"
	"thrc/infra/mysql"
	"thrc/service/user/conf"
	"thrc/service/user/service/grpc/proto/user"
	"thrc/service/user/service/grpc/server"
)

func main() {
	port := conf.GetSrvPort()
	node := conf.GetNodeInfo()
	dbCfg := conf.GetDBConfig()
	db, err := mysql.NewMySqlDB(dbCfg)
	if err != nil {
		panic("database init fail")
	}

	dis, err := discovery.NewDiscovery()
	if err != nil {
		panic("can't get Discovery service")
	}

	listen, err := net.Listen("tcp", "0.0.0.0:"+port)
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	tracer, reporter, err := jaeger.GetTracer("user grpc server")
	if err != nil {
		panic("tracer init fail")
	}
	defer reporter.Close()

	s := grpc.NewServer(grpc.UnaryInterceptor(
		grpc_opentracing.UnaryServerInterceptor(
			grpc_opentracing.WithTracer(tracer),
		)))

	svr := server.New(db)
	user.RegisterUserServer(s, svr)

	log.Println("User gRPC Service listen on: " + port)

	go func() {
		if err := s.Serve(listen); err != nil {
			log.Fatalf("Failed to serve: %v", err)
		}
	}()

	dis.Register(node)

	conf.WatchDBChanged(func(key string, value interface{}) {
		log.Println(key, value)
		db, err := mysql.NewMySqlDB(conf.GetDBConfig())
		if err != nil {
			log.Println("err: ", err)
		}
		svr.Reload(db)
	})

	select {}
}
