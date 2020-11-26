FROM alpine:3.9.5

COPY ./bin/interface/gateway /usr/bin/gateway

ENTRYPOINT ["/usr/bin/gateway"]
