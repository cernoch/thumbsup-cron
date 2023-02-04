#!/bin/sh
set -eu

if [ "$(id -u)" = '0' ]; then
  chown "${PUID}:${PGID}" /var/local/thumbsup
  exec su-exec "${PUID}:${PGID}" "$@"
else
  exec "$@"
fi
