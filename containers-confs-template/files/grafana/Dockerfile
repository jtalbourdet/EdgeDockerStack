ARG VERSION
ARG INFLUXDB_DATASOURCE_USER
ARG INFLUXDB_DATASOURCE_PASSWORD



FROM grafana/grafana:${VERSION}

ARG INFLUXDB_DATASOURCE_USER
ARG INFLUXDB_DATASOURCE_PASSWORD


USER root

COPY provisioning /etc/grafana/provisioning
COPY dashboards /var/lib/grafana/dashboards
COPY config/grafana.ini /etc/grafana/grafana.ini
COPY img /usr/share/grafana/public/img

SHELL ["/bin/bash", "-c"]

RUN sed -i "s/user:.*/user: $INFLUXDB_DATASOURCE_USER/" /etc/grafana/provisioning/datasources/datasource.yaml
RUN sed -i "s/password:.*/password: $INFLUXDB_DATASOURCE_PASSWORD/" /etc/grafana/provisioning/datasources/datasource.yaml