FROM httpd:2.4.59-alpine3.19
LABEL org.opencontainers.image.authors="SuperFlyXXI <superflyxxi@yahoo.com>"
ENTRYPOINT ["/entrypoint.sh"]

RUN apk add --no-cache dcron
RUN rm /usr/local/apache2/htdocs/index.html

ADD entrypoint.sh /
