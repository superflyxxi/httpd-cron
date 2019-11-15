docker run --rm -d --name test -v "`pwd`/crontab:/etc/crontabs/root:ro" -v "`pwd`:/home/test" httpd-cron:build
sleep 2m
docker stop test
cat ./minute.log
