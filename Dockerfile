FROM httpd:alpine
MAINTAINER SuperFlyXXI <superflyxxi@yahoo.com>

RUN apk add --no-cache dcron

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

