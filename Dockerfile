FROM ghcr.io/thumbsup/thumbsup
RUN apk add --no-cache su-exec 
COPY entrypoint.sh thumbsup-cron.sh /usr/local/bin/

ENV PUID=1000 PGID=1000
ENTRYPOINT ["tini", "-g", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/thumbsup-cron.sh"]
