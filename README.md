## Introduction
This code will provide a docker image that will host cron and httpd. This way you can have your scripts run periodically
and post to the publich html directory for results.

The crontab provided via volumes should be owned by root before mounting. Alternatively, building images and adding 
files should be fine.

## Customizing
The script will execute `/before_entrypoint.sh` if it exists before starting cron or the httpd server.

## Example
### Sample cron
```
* * * * * * date >> /usr/local/apache2/htdocs/dates.html
```

### Example run
```sh
docker run --rm -it -p 80:80 -v "`pwd`/crontab.txt:/etc/crontabs/root:ro" image
```


