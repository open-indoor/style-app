##############################################
FROM caddy:2-alpine

RUN apk add --update-cache \
    bash \
    curl \
    file \
    gettext \
    grep \
    jq \
    net-tools \
    procps \
    util-linux \
    vim \
    wget \
    && rm -rf /var/cache/apk/*

RUN apk add --update-cache \
    python3 py3-pip py3-wheel curl-dev \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /style

ENV API_DOMAIN_NAME api.openindoor.io
ENV APP_DOMAIN_NAME app.openindoor.io
ENV INDOOR_MIN_ZOOM 18
ENV BUILDING_MIN_ZOOM 15
ENV BUILDING_MAX_ZOOM 18

CMD /usr/bin/style-app.sh
EXPOSE 80

COPY ./Caddyfile /etc/caddy/Caddyfile
COPY ./tic.sh /usr/bin/tic
COPY ./actions.sh /usr/bin/actions.sh
COPY ./processStyle.py /usr/bin/processStyle

COPY ./style-app.sh /usr/bin/style-app.sh
RUN chmod +x /usr/bin/style-app.sh
COPY ./style/ /tmp/style/
