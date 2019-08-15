ARG ALPINE_VERSION=latest
ARG GOLANG_VERSION=1.12.5
ARG DESYNC_VERSION=v0.7.1

FROM golang:${GOLANG_VERSION}-alpine as builder
MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>

ENV LANG=C.UTF-8

# Install base packages
RUN apk -U add --no-cache \
    ca-certificates wget curl git \
    make autoconf automake libtool alpine-sdk \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /src && \
	git clone https://github.com/folbricht/desync.git /src/desync && \
	cd /src/desync && \
	git checkout ${DESYNC_VERSION}
RUN	cd /src/desync && go install ./cmd/desync
RUN cp "$(go env GOPATH)"/bin/desync /usr/bin


FROM alpine:${ALPINE_VERSION}
MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>

ENV LANG=C.UTF-8

RUN apk -U add ca-certificates bash \
	curl openssl \
  && rm -rf /var/cache/apk/*

WORKDIR /
COPY --from=builder /usr/bin/desync /usr/bin/

CMD ["/usr/bin/desync"]
