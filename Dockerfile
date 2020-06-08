FROM golang:1.14.4 as builder

ENV VERSION=v1.17.0

RUN set -xe; \
    apt-get update && apt-get install -y openssl libssl1.1 libgnutls30; \
    mkdir /tmp/kops; \
    cd /tmp/kops; \
    git init; \
    git remote add origin https://github.com/kubernetes/kops.git; \
    git checkout -b $VERSION; \
    git fetch origin --depth 1 $VERSION; \
    git reset --hard FETCH_HEAD; \
    cd /tmp/kops/node-authorizer/cmd/node-authorizer; \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build .

FROM scratch as release

COPY --from=builder /tmp/kops/node-authorizer/cmd/node-authorizer/node-authorizer /node-authorizer
COPY --from=builder /etc/ssl /etc/ssl

ENTRYPOINT ["/node-authorizer"]
