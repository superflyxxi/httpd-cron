#!/bin/sh

if [[ -x "/before_entrypoint.sh" ]]; then
	echo "Executing before entrypoint"
	/before_entrypoint.sh
fi
	
echo "Starting cron server"
crond -b -L /var/log/cron.log -l 7

echo "Starting httpd server"
httpd-foreground

# Kill crond
ps | grep crond | grep -v grep | awk '{print $1}' | xargs kill
