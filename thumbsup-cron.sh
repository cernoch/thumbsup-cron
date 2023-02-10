#!/bin/sh
set -eu
export HOME=/var/local/thumbsup
while true; do
  thumbsup --log info --input /var/local/thumbsup/input --output /var/local/thumbsup/output
  sleep $THUMBSUP_REFRESH_INTERVAL
done
