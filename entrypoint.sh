#!/bin/sh
echo "Starting cron server"
crond -b -L /var/log/cron.log

echo "Starting httpd server"
httpd-foreground


