FROM httpd:alpine
MAINTAINER SuperFlyXXI <superflyxxi@yahoo.com>

RUN apk add --no-cache dcron

RUN rm /usr/local/apache2/htdocs/index.html

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

