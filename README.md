# thumbsup-cron

Docker image that runs the excellent
[thumbsup](https://github.com/thumbsup/thumbsup)
static web gallery generator repeatedly. 

## How to build

```
$ docker build -t cernoch/thumbsup-cron:latest https://github.com/cernoch/thumbsup-cron.git#main
```

## How to use

Create a `docker-compose.yml` file:

```yml
version: '3.4'
services:
  thumbsup-cron:
    image: "cernoch/thumbsup-cron:latest"
    restart: always
    volumes:
      - "[PATH_TO_YOUR_PHOTOS]:/var/local/thumbsup/input:ro"
      - "[PATH_TO_THE_GALLERY]:/var/local/thumbsup/output"
    environment:
      - PUID=[UID_OF_GALLERY_FILES]
      - PGID=[GID_OF_GALLERY_FILES]
```

And the just `docker compose --detach`.

Don't forget that `[PATH_TO_THE_GALLERY]` must be writable by `[UID_OF_GALLERY_FILES]`!

