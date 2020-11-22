FROM alpine:3.9.5

COPY ./bin/service/user-service /usr/bin/user-service

ENTRYPOINT ["/usr/bin/user-service"]
