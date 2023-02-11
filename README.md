# thumbsup-cron

Docker image that runs the excellent
[thumbsup](https://github.com/thumbsup/thumbsup)
static web gallery generator repeatedly. 

## Quickstart

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


## How to adjust

On **Windows**, feel free to delete the `PUID` and `PGID` variables.

On **Linux**, don't forget that `[PATH_TO_THE_GALLERY]` must be writable by `[UID_OF_GALLERY_FILES]`.

### Using json for configuration

Thumbsup let's you put (complex) config into a single `.json` file:

```
$ mkdir config
$ echo '{ "input":"./input", "output":"./output" }' > config/config.json
```

Then modify `docker-compose.yml`:

```yml
version: '3.4'
services:
  thumbsup-cron:
    image: "ghcr.io/cernoch/thumbsup-cron:latest"
    command: ["thumbsup-cron.sh", "--config", "config/config.json"]
    restart: always
    volumes:
      - "./config:/var/local/thumbsup/config:ro"
      - "[PATH_TO_YOUR_PHOTOS]:/var/local/thumbsup/input:ro"
      - "[PATH_TO_THE_GALLERY]:/var/local/thumbsup/output"
    environment:
      - THUMBSUP_REFRESH_INTERVAL=15s
      - PUID=[UID_OF_GALLERY_FILES]
      - PGID=[GID_OF_GALLERY_FILES]
```


### Symlinks to original photos

If you want to use `--photo-download=symlink` (or `--video-download=symlink`),
unfortunately, thumbsup uses absolute paths. Therefore `[PATH_TO_YOUR_PHOTOS]`
must be mapped to the same path in the Docker container. Edit `docker-compose.yml`:

```yml
version: '3.4'
services:
  thumbsup-cron:
    image: "ghcr.io/cernoch/thumbsup-cron:latest"
    command: ["thumbsup-cron.sh", "--input", "[PATH_TO_YOUR_PHOTOS]", "--output", "./output"]
    restart: always
    volumes:
      - "[PATH_TO_YOUR_PHOTOS]:[PATH_TO_YOUR_PHOTOS]:ro"
      - "[PATH_TO_THE_GALLERY]:/var/local/thumbsup/output"
    environment:
      - THUMBSUP_REFRESH_INTERVAL=15s
      - PUID=[UID_OF_GALLERY_FILES]
      - PGID=[GID_OF_GALLERY_FILES]
```


## How to build yourself

```
$ git clone https://github.com/cernoch/thumbsup-cron.git
$ cd thumbsup-cron
$ docker build -t ghcr.io/cernoch/thumbsup-cron:latest .
```


## How to release

- Release commit is tagged as `v[MAJOR].[PATCH]`.
- Backwards compatible changes may only bump the `PATCH` version.
- When bumping the `PATCH` version, just tag the commit & push.
- When bumping the `MAJOR` version, also update the `ghcr.io/cernoch/thumbsup-cron:[MAJOR]` tag in `.github/workflows/main.yml`.
