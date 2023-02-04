#!/bin/sh
export HOME=/var/local/thumbsup
while true; do
  thumbsup --log info --input /var/local/thumbsup/input --output /var/local/thumbsup/output
  sleep 10
done
