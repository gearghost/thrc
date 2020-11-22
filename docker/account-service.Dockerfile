FROM alpine:3.9.5

COPY ./bin/service/account-service /usr/bin/account-service

ENTRYPOINT ["/usr/bin/account-service"]
