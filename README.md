Docker image of jrudess' [StreamDVR](https://github.com/jrudess/streamdvr) app.

### Usage
```
docker run --name=streamdvr \
-v /path/to/config:/app/config \
-v /path/to/capturing:/app/capturing \
-v /path/to/captured:/app/captured \
ghcr.io/purrsevere/streamdvr:latest
```

### Docker Compose
```
version: "3"
services:
  streamdvr:
    container_name: streamdvr
    image: ghcr.io/purrsevere/streamdvr:latest
    restart: on-failure
    volumes:
      - /path/to/config:/app/config
      - /path/to/capturing:/app/capturing
      - /path/to/captured:/app/captured
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
```

### Notes
* If you want your changes to persist, include a copy of the config folder and bind mount it to the app at /app/config. 

### Changelog:
* **November 6, 2023** Package updates: StreamDVR Latest, Alpine 3.18, yt-dlp 2023.10.13, node 21.
* **August 2nd, 2021** Package updates: StreamDVR v0.14, Alpine 3.14, youtube-dl 2021.06.06 & streamlink 2.3.0
* **May 3rd, 2021:** Rebase image to LinuxServer.io's Alpine image for customizable permissions.
* **November 24, 2020:** Upgrade packages: Alpine 3.12, youtube-dl 2020.11.24, streamlink 1.7.0. Added healthcheck via [healthchecks.io](https://healthchecks.io/).
* **January 22, 2020:** Upgrade to Alpine 3.11. Upgraded packages: ffmpeg 4.2.1, streamlink 1.3.0, youtube-dl 2020.01.15.
* **November 8, 2019:** Upgrade ffmpeg to 4.1.4; Upgrade node to v13;
* **May 22, 2019:** Upgrade ffmpeg to 4.1.3; Add tags for release/commit versions.
* **April 23, 2019:** Rebase to Alpine 3.9; Update StreamDVR version.
* **December 10, 2018:** Update ffmpeg to v4.0.
* **November 25, 2018:** Update dependencies, cleanup image.
* **October 30, 2018:** Initial release.
