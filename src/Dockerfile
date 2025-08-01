FROM httpd:2.4.65
LABEL org.opencontainers.image.authors="SuperFlyXXI <superflyxxi@yahoo.com>"
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get update && \
	apt-get install -y --no-install-recommends cron procps && \
	apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN rm /usr/local/apache2/htdocs/index.html

ADD entrypoint.sh /
