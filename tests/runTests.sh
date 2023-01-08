log() {
	echo $(date -Iseconds) "$1"
}

TEST_IMAGE=${TEST_IMAGE:-httpd-cron:build}
SECONDS_BEFORE_START=$(($(date +%s) % 60))
if [[ ${SECONDS_BEFORE_START} -gt 50 ]]; then
	log "There's less than 10 seconds before start of next minute. Sleepin for 15 seconds."
	sleep 15s
fi

log "Running docker"
docker build -t httpd-cron:test -f- . <<EOF
FROM ${TEST_IMAGE}
RUN mkdir -p /home/test
ADD crontab /etc/crontabs/root
EOF
docker run --rm -d --init --name test httpd-cron:test

# 60 minus number of seconds past 00... +  5 seconds for buffer
SECONDS_TO_SLEEP=$((65 - $(date +%s) % 60))
log "Sleeping for ${SECONDS_TO_SLEEP} second(s)"
sleep ${SECONDS_TO_SLEEP}s

SECONDS_DOCKER_STOP=$(date +%s)
docker cp test:/home/test/minute.log ./minute.log
docker cp test:/var/log/cron.log ./cron.log
docker stop --time 10 test
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

