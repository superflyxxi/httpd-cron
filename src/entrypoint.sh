#!/bin/sh
echo "Starting cron server"
crond -b -L /var/log/cron.log -l 7

echo "Starting httpd server"
httpd-foreground

