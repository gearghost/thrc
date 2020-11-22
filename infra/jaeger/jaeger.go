package jaeger

import (
	"github.com/opentracing/opentracing-go"
	"github.com/uber/jaeger-client-go"
	jaegercfg "github.com/uber/jaeger-client-go/config"
	"io"
)

func GetTracer(servicename string) (opentracing.Tracer, io.Closer, error) {
	jcfg := jaegercfg.Configuration{
		Sampler: &jaegercfg.SamplerConfig{
			Type:  "const",
			Param: 1,
		},
		ServiceName: servicename,
	}
	report := jaegercfg.ReporterConfig{
		LogSpans:           true,
		LocalAgentHostPort: "localhost:6831",
		//LocalAgentHostPort: "host.minikube.internal:6831",
	}
	reporter, err := report.NewReporter(servicename,
		jaeger.NewNullMetrics(),
		jaeger.NullLogger)
	if err != nil {
		return nil, nil, err
	}

	tracer, closer, err := jcfg.NewTracer(
		jaegercfg.Reporter(reporter),
	)
	if err != nil {
		return nil, nil, err
	}
	return tracer, closer, nil
}
