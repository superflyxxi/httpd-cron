#!/bin/bash

if [[ -x "/before_entrypoint.sh" ]]; then
	echo "Executing before entrypoint"
	/before_entrypoint.sh
fi
	
echo "Starting cron server"
cron -L 7 -l

echo "Starting httpd server"
httpd-foreground

# Kill crond
kill $(cat /var/run/crond.pid)
