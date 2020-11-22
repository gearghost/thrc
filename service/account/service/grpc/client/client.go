package client

import (
	"thrc/service/account/service/grpc/proto/account"

	grpc_opentracing "github.com/grpc-ecosystem/go-grpc-middleware/tracing/opentracing"
	"github.com/opentracing/opentracing-go"
	"google.golang.org/grpc"
	"google.golang.org/grpc/resolver"
)

type AccountClient struct {
	conn *grpc.ClientConn
	Call account.AccountClient
}

func GetClient(r resolver.Builder, appid string, tracer opentracing.Tracer) (*AccountClient, error) {
	/*node := dis.GetNode()
	if node == nil {
		return nil, errors.New("no account service node found")
	}*/
	resolver.Register(r)
	conn, err := grpc.Dial(
		r.Scheme()+"://author/"+appid,
		grpc.WithBalancerName("round_robin"),
		grpc.WithInsecure(),
		grpc.WithUnaryInterceptor(grpc_opentracing.UnaryClientInterceptor(
			grpc_opentracing.WithTracer(tracer)),
		))
	if err != nil {
		return nil, err
	}
	accountcli := account.NewAccountClient(conn)
	return &AccountClient{conn: conn, Call: accountcli}, nil
}

func (c *AccountClient) Close() {
	c.conn.Close()
}
