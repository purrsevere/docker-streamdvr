FROM node:21-alpine3.18

ARG HEALTHCHECKS_ID
ENV YT_DLP_VERSION=2023.10.13

RUN echo "**** install dependencies ****" && \
		apk add --no-cache curl python3 py3-pip py3-setuptools ca-certificates bash git build-base libgomp ffmpeg &&\
    echo "**** install yt-dlp ****" && \
    pip3 install yt-dlp==${YT_DLP_VERSION} && \
    echo "**** install streamdvr ****" && \
    git clone https://github.com/jrudess/streamdvr.git /app && cd /app && \
    echo "Currently on commit:" $(git rev-parse --short HEAD && git log -1 --pretty=%B) && \
    npm ci --only=production && \
    echo "**** cleanup ****" && \
		npm cache clean --force && \
    apk del git build-base && \
    rm -rf /tmp/* && \
    chown 1000:1000 -R /app

WORKDIR /app

VOLUME /app/config /app/capturing /app/captured

USER node

CMD ["node", "streamdvr"]

STOPSIGNAL SIGINT

HEALTHCHECK --interval=300s --timeout=15s --start-period=10s \
            CMD curl -L https://hc-ping.com/${HEALTHCHECKS_ID}
