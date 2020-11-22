package client

import (
	grpc_opentracing "github.com/grpc-ecosystem/go-grpc-middleware/tracing/opentracing"
	"github.com/opentracing/opentracing-go"
	"google.golang.org/grpc"
	"google.golang.org/grpc/resolver"
	"thrc/service/user/service/grpc/proto/user"
)

type UserClient struct {
	conn   *grpc.ClientConn
	Call   user.UserClient
	tracer opentracing.Tracer
}

func GetClient(r resolver.Builder, appid string, tracer opentracing.Tracer) (*UserClient, error) {
	/*node := dis.GetNode()
	if node == nil {
		return nil, errors.New("no user service node found")
	}*/
	resolver.Register(r)
	conn, err := grpc.Dial(
		r.Scheme()+"://author/"+appid,
		grpc.WithBalancerName("round_robin"),
		grpc.WithInsecure(),
		grpc.WithUnaryInterceptor(
			grpc_opentracing.UnaryClientInterceptor(
				grpc_opentracing.WithTracer(tracer))),
	)
	if err != nil {
		return nil, err
	}
	usercli := user.NewUserClient(conn)
	return &UserClient{conn: conn, Call: usercli}, nil
}

func (c *UserClient) Close() {
	c.conn.Close()
}
