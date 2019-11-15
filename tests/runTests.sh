docker run --rm -d --name test -v "`pwd`/crontab:/etc/crontabs/root:ro" -v "`pwd`:/home/test" httpd-cron:build
sleep 2m
docker logs test
docker stop test
ls -lha ./
cat ./minute.log
