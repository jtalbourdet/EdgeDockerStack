ARG VERSION

FROM nodered/node-red:${VERSION}

USER root

COPY config/settings.js /data/settings.js

SHELL ["/bin/bash", "-c"]

RUN npm install -g --unsafe-perm node-red-admin