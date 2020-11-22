package apollo

import (
	"testing"
)

func TestApollo(t *testing.T) {
	cli := NewApolloClient("application", "SampleApp", "08407f0573b94cd8a30b1e2acfce5436")
	timeout := cli.Get("timeout")
	if timeout == nil {
		t.Error("timeout is nil")
	}
	t.Log("timeout:", timeout)
	cli.AddChangeListener(&DefaultChangeListener{})
	select {}
}
