touch cron.log
touch minute.log

log() {
	echo $(date -Iseconds) "$1"
}

SECONDS_BEFORE_START=$(($(date +%s) % 60))
if [[ ${SECONDS_BEFORE_START} -gt 50 ]]; then
	log "There's less than 10 seconds before start of next minute. Sleepin for 15 seconds."
	sleep 15s
fi

log "Running docker"
docker run --rm -d --name test -v "`pwd`/crontab:/etc/crontabs/root:ro" -v "`pwd`/cron.log:/var/log/cron.log" -v "`pwd`/minute.log:/home/test/minute.log" httpd-cron:build

# 60 minus number of seconds past 00... +  5 seconds for buffer
SECONDS_TO_SLEEP=$((65 - $(date +%s) % 60))
log "Sleeping for ${SECONDS_TO_SLEEP} second(s)"
sleep ${SECONDS_TO_SLEEP}s

SECONDS_DOCKER_STOP=$(date +%s)
docker stop --time 30 test
SECONDS_DOCKER_STOP=$(($(date +%s) - ${SECONDS_DOCKER_STOP}))
log "Docker took ${SECONDS_DOCKER_STOP}s to stop"

log "Validating test"
LINES=$(wc -l < ./minute.log)
if [[ ${LINES} -eq 1 ]]; then
	log "PASS: Perfection (${LINES})"
else
	log "FAIL: Expected 1 line, but got ${LINES}"
	log "Cron logs"
	cat ./cron.log
	log "Test results"
	cat ./minute.log
	exit 1
fi

