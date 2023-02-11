#!/bin/sh
set -eu
export HOME=/var/local/thumbsup
cd "$HOME"
while true; do
  thumbsup "$@"
  sleep $THUMBSUP_REFRESH_INTERVAL
done
