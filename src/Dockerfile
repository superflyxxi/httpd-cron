FROM httpd:alpine
MAINTAINER SuperFlyXXI <superflyxxi@yahoo.com>

RUN apk add --no-cache dcron curl

HEALTHCHECK --interval=1m --timeout=10s \
	CMD curl --fail http://localhost:80/

RUN rm /usr/local/apache2/htdocs/index.html

ENTRYPOINT ["/entrypoint.sh"]

ADD entrypoint.sh /

