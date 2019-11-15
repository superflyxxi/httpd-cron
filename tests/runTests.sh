touch cron.log
touch minute.log
chown root:root crontab
echo "Running docker"
docker run --rm -d --name test -v "`pwd`/crontab:/etc/crontabs/root:ro" -v "`pwd`/cron.log:/var/log/cron.log" -v "`pwd`/minute.log:/home/test/minute.log" httpd-cron:build
echo "Sleeping for 1 minute(s)"
date
sleep 1m
date
echo "View docker logs"
docker logs test
docker stop test

echo "Viewing cron logs"
cat ./cron.log

echo "Validating test"
echo "Actual output"
cat ./minute.log
echo "Number of lines"
LINES=$(wc -l < ./minute.log)
if [[ ${LINES} -eq 1 ]]; then
	echo "PASS: Perfection (${LINES})"
else
	echo "FAIL: Expected 1 line, but got ${LINES}"
	exit 1
fi

