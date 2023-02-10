FROM ghcr.io/thumbsup/thumbsup:2.16.0
RUN apk add --no-cache su-exec
COPY entrypoint.sh thumbsup-cron.sh /usr/local/bin/

ENV PUID=1000 PGID=1000 THUMBSUP_REFRESH_INTERVAL=15s
ENTRYPOINT ["tini", "-g", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/thumbsup-cron.sh"]
