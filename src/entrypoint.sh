#!/bin/sh
echo "Starting cron server"
crond -b -L /var/log/cron.log -l 7

echo "Starting httpd server"
httpd-foreground

# Kill crond
ps | grep crond | grep -v grep | awk '{print $1}' | xargs kill
