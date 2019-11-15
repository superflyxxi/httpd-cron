#!/bin/sh
echo "Starting cron server"
crond -s /var/spool/cron/crontabs -b -L /var/log/cron.log

echo "Starting httpd server"
httpd-foreground


