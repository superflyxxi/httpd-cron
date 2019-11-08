#!/bin/sh
echo "Starting cron server"
crond -s /var/spool/cron/crontabs -b -L /dev/stdout

echo "Starting httpd server"
httpd-foreground


