FROM node:22-alpine3.21

ENV YT_DLP_VERSION=2025.06.30
ENV STREAMLINK_VERSION=7.5.0

RUN echo "**** install dependencies ****" && \
    apk add --no-cache curl python3 py3-setuptools ca-certificates bash git build-base libgomp ffmpeg tzdata && \
    python3 -m pip install --upgrade pip setuptools && \
    echo "**** install yt-dlp ****" && \
    curl -L https://github.com/yt-dlp/yt-dlp/releases/download/${YT_DLP_VERSION}/yt-dlp_linux -o /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp && \
    echo "**** install streamlink ****" && \
    curl -L https://github.com/streamlink/streamlink/releases/download/${STREAMLINK_VERSION}/streamlink-${STREAMLINK_VERSION}.tar.gz -o /tmp/streamlink.tar.gz && \
    tar -xzf /tmp/streamlink.tar.gz -C /tmp && \
    cd /tmp/streamlink-${STREAMLINK_VERSION} && \
    python3 setup.py install && \
    echo "**** install streamdvr ****" && \
    git clone --depth=1 https://github.com/jrudess/streamdvr.git /app && cd /app && \
    echo "Currently on commit:" $(git rev-parse --short HEAD && git log -1 --pretty=%B) && \
    npm ci --only=production && \
    echo "**** cleanup ****" && \
    npm cache clean --force && \
    apk del git build-base && \
    rm -rf /tmp/* /var/cache/apk/* && \
    chown 1000:1000 -R /app

WORKDIR /app

VOLUME /app/config /app/capturing /app/captured

USER node

CMD ["node", "streamdvr"]

STOPSIGNAL SIGINT
