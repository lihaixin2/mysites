#
# Dockerfile for fteproxy
#

FROM alpine:3.7
MAINTAINER LEE <norelpy@lihaixin.name>

RUN set -xe \
    && apk add -U build-base \
                  gmp \
                  gmp-dev \
                  libstdc++ \
                  python \
                  python-dev \
                  py-pip \
    && pip install --upgrade pip \
    && pip install fteproxy \
    && apk del build-base \
               gmp-dev \
               python-dev \
    && rm -rf /root/.cache /var/cache/apk/*

ENV MODE server
ENV UPSTREAM_FORMAT manual-http-request
ENV DOWNSTREAM_FORMAT manual-http-response
ENV CLIENT_IP 0.0.0.0
ENV CLIENT_PORT 8079
ENV SERVER_IP 127.0.0.1
ENV SERVER_PORT 8080
ENV PROXY_IP 127.0.0.1
ENV PROXY_PORT 8081
ENV RELEASE 20131224
#ENV KEY 9612EDA858C8B26EA5DF97956A41B2786867EC22ECD5C6B754E81F50DA093414

EXPOSE 8079

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
