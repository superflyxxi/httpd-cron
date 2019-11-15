touch cron.log
touch minute.log

log() {
	echo $(date -Iseconds) "$1"
}

log "Running docker"
docker run --rm -d --name test -v "`pwd`/crontab:/etc/crontabs/root:ro" -v "`pwd`/cron.log:/var/log/cron.log" -v "`pwd`/minute.log:/home/test/minute.log" httpd-cron:build

log "Sleeping for 1 minute(s)"
sleep 1m

log "Timing docker stop"
docker stop test
log "Done stopping docker"

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

