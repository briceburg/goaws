FROM golang:1.14.3-alpine3.11 as builder
WORKDIR /go/src/github.com/p4tin/goaws
RUN apk add --no-cache git dep
COPY . .
RUN dep init && dep ensure && GOOS=linux GOARCH=amd64 go build -o goaws app/cmd/goaws.go

FROM alpine:3.11
EXPOSE 4100
ENTRYPOINT ["/goaws"]
COPY --from=builder /go/src/github.com/p4tin/goaws/goaws /goaws
COPY app/conf/goaws.yaml /conf/
