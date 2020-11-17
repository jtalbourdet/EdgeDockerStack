#!/bin/bash

CONF_FILE_PATH=".env"
TELEGRAF_CONF_FILE_PATH="containers-confs/files/telegraf/config/telegraf.conf"
GRAFANA_DATASOURCE_FILE_PATH="containers-confs/files/grafana/provisioning/datasources/datasource.yaml"


if [ -x "$(command -v docker)" ]; then
    echo "* Docker already installed"
else
    echo "* Docker ipk download"
    wget https://github.com/WAGO/docker-ipk/releases/download/v1.0.3/docker_19.03.13_armhf.ipk
    echo "* Docker ipk installation"
    opkg install docker_19.03.13_armhf.ipk
    rm docker_19.03.13_armhf.ipk
fi

echo "* Stop Docker daemon"
/etc/init.d/dockered stop
sdVolumeName=$(df -h | grep -w 'dev' | grep -w 'media' | sed 's/.*media\///' | sed 's/\/.*//' | sed '2,100 d')
if [ -z $sdVolumeName ]; then
    echo "* No SD or µSD card detected"
else
    read -p "* Enter or confirm the SD or µSD volume name : [$sdVolumeName]" newSdVolumeName
    if [ -z $newSdVolumeName ]; then
        sdVolumeName=$sdVolumeName
    else
        sdVolumeName=$newSdVolumeName
    fi
    echo "* Use $sdVolumeName"
    echo "* Replace Docker directory from /home/docker to /media/$sdVolumeName/docker"
    sed "s/\"data-root\":\"\/.*\/docker\",/\"data-root\":\"\/media\/$sdVolumeName\/docker\",/" /etc/docker/daemon.json
fi
echo "* Start Docker daemon"
/etc/init.d/dockered stop
if [ -x "$(command -v docker)" ]; then
    echo "* Docker-compose already installed"
else
    echo "* Docker-compose ipk download"
    wget https://github.com/WAGO/docker-compose-ipk/raw/master/docker_compose_1.21.1_armhf.ipk
    echo "* Docker-compose ipk installation"
    opkg install docker_compose_1.21.1_armhf.ipk
    rm docker_19.03.13_armhf.ipk
fi

echo "* Create configuration directory \"containers-confs\""
cp -r containers-confs-template containers-confs
echo "* Create configuration file \".env\""
cp .env-template .env


read -p "* Create Admin username:" adminUserName
read -p "* Create Admin password:" adminPassword

echo "* Configure influxdb username and password"
sed "s/GENERIC_ADMIN_USER=.*/GENERIC_ADMIN_USER=$adminUserName/" $CONF_FILE_PATH > $CONF_FILE_PATH
sed "s/GENERIC_ADMIN_PASSWORD=.*/GENERIC_ADMIN_PASSWORD=$adminPassword/" $CONF_FILE_PATH > $CONF_FILE_PATH

echo "* Configure grafana influxdb datasource"
sed "s/user:.*/user:$adminUserName/" $GRAFANA_DATASOURCE_FILE_PATH > $GRAFANA_DATASOURCE_FILE_PATH
sed "s/password:.*/password:$adminPassword/" $GRAFANA_DATASOURCE_FILE_PATH > $GRAFANA_DATASOURCE_FILE_PATH

echo "* Configure telegraf influxdb connection"
sed "s/username =.*/username = \"$adminUserName\"/" $TELEGRAF_CONF_FILE_PATH > $TELEGRAF_CONF_FILE_PATH
sed "s/password =.*/password = \"$adminPassword\"/" $TELEGRAF_CONF_FILE_PATH > $TELEGRAF_CONF_FILE_PATH



echo "* Create containers"
docker-compose -f "docker-compose.yml" up -d --build


echo "* You can now publish your MQTT message on the metrics\/ topic and visualize them in Grafana from the db_metrics database"



