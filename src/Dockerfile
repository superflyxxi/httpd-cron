FROM httpd:2.4.54-alpine3.17
LABEL org.opencontainers.image.authors="SuperFlyXXI <superflyxxi@yahoo.com>"
ENTRYPOINT ["/entrypoint.sh"]

RUN apk add --no-cache dcron=4.5-r8
RUN rm /usr/local/apache2/htdocs/index.html

ADD entrypoint.sh /
