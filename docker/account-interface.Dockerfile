FROM alpine:3.9.5

COPY ./bin/interface/account-interface /usr/bin/account-interface

ENTRYPOINT ["/usr/bin/account-interface"]
