# thumbsup-cron

Docker image that runs the excellent
[thumbsup](https://github.com/thumbsup/thumbsup)
static web gallery generator repeatedly. 

## How to use

Create a `docker-compose.yml` file:

```yml
version: '3.4'
services:
  thumbsup-cron:
    image: "ghcr.io/cernoch/thumbsup-cron:latest"
    restart: always
    volumes:
      - "[PATH_TO_YOUR_PHOTOS]:/var/local/thumbsup/input:ro"
      - "[PATH_TO_THE_GALLERY]:/var/local/thumbsup/output"
    environment:
      - THUMBSUP_REFRESH_INTERVAL=15s
      - PUID=[UID_OF_GALLERY_FILES]
      - PGID=[GID_OF_GALLERY_FILES]
```

And the just `docker compose up --detach`.

- **Windows**: Feel free to delete the `environment` section.
- **Linux**: Don't forget that `[PATH_TO_THE_GALLERY]` must be writable by `[UID_OF_GALLERY_FILES]`!


## How to build

```
$ docker build -t ghcr.io/cernoch/thumbsup-cron:latest https://github.com/cernoch/thumbsup-cron.git#main
```


## How to release

- Release commit is tagged as `v[MAJOR].[PATCH]`.
- Backwards compatible changes may only bump the `PATCH` version.
- When bumping the `PATCH` version, just tag the commit & push.
- When bumping the `MAJOR` version, also update the `ghcr.io/cernoch/thumbsup-cron:[MAJOR]` tag in `.github/workflows/main.yml`.
