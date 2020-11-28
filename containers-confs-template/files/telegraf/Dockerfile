ARG VERSION
ARG INFLUXDB_OUTPUT_USER
ARG INFLUXDB_OUTPUT_PASSWORD

FROM telegraf:${VERSION}

ARG INFLUXDB_OUTPUT_USER
ARG INFLUXDB_OUTPUT_PASSWORD

USER root

COPY config/telegraf.conf /etc/telegraf/telegraf.conf

SHELL ["/bin/bash", "-c"]

RUN sed -i "s/username =.*/username = \"$INFLUXDB_OUTPUT_USER\"/" /etc/telegraf/telegraf.conf
RUN sed -i "s/password =.*/password = \"$INFLUXDB_OUTPUT_PASSWORD\"/" /etc/telegraf/telegraf.conf