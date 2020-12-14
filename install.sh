#!/bin/bash

CONF_FILE_PATH=".env"
DOCKER_COMPOSE_FILE_PATH="docker-compose.yml"
DOCKER_CONF_FILE_PATH="/etc/docker/daemon.json"
INSTALL_LOG_FILE_PATH="installLogs.log"
TELEGRAF_CONF_FILE_PATH="containers-confs/files/telegraf/config/telegraf.conf"
GRAFANA_DATASOURCE_FILE_PATH="containers-confs/files/grafana/provisioning/datasources/datasource.yaml"

echo " "
echo " EdgeDockerStack intallation from https://github.com/Talbourdet/EdgeDockerStack " 
echo " "


echo "* Download EdgeDockerStack repository"
wget https://github.com/Talbourdet/EdgeDockerStack/archive/master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
echo "* Unzip content"
unzip master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
rm master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
mv -f EdgeDockerStack-master EdgeDockerStack

chmod 777 -R EdgeDockerStack >> $INSTALL_LOG_FILE_PATH 2>&1

mv $INSTALL_LOG_FILE_PATH EdgeDockerStack/$INSTALL_LOG_FILE_PATH

cd EdgeDockerStack


if [ -x "$(command -v docker)" ]; then
    echo "* Docker installation: OK"
else
    echo "* Docker is not installed please install it"
fi

if [ -x "$(command -v docker-compose)" ]; then
    echo "* Docker-compose installation: OK"
else
    echo "* Docker-compose not installed please install it"
fi

echo "* Create configuration directory \"containers-confs\""
cp -R -f containers-confs-template containers-confs >> $INSTALL_LOG_FILE_PATH 2>&1
echo "* Create configuration file \".env\""
cp -R -f .env-template .env >> $INSTALL_LOG_FILE_PATH 2>&1

read -e -p "* Activate node-red container (yes/no) : [no]" activateNodeRed
if [ $activateNodeRed = "yes"  ] || [ $activateNodeRed = "YES"  ]; then
    activateNodeRed=true
    echo "* Activate node-red container"
    sed -i "s/  # node-red-service:/  node-red-service:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   image: nodered\/node-red:\${NODERED_VERSION}/    image: nodered\/node-red:\${NODERED_VERSION}/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   volumes:/    volumes:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #     - .\/containers-confs\/files\/node-red\/config:\/data/      - .\/containers-confs\/files\/node-red\/config:\/data/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   ports:/    ports:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #     - 1880:1880/      - 1880:1880/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   restart: unless-stopped/    restart: unless-stopped/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
elif [ $activateNodeRed = "no"  ] || [ $activateNodeRed = "NO"  ]; then
    activateNodeRed=false
    echo "* Desactivate node-red container"
else
    activateNodeRed=false
    echo "* Desactivate node-red container"
fi

read -e -p "* Create Admin username:" adminUserName
read -e -p "* Create Admin password:" adminPassword

echo "* Configure influxdb username and password"
sed -i "s/GENERIC_ADMIN_USER=.*/GENERIC_ADMIN_USER=$adminUserName/" $CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/GENERIC_ADMIN_PASSWORD=.*/GENERIC_ADMIN_PASSWORD=$adminPassword/" $CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH

echo "* Configure grafana influxdb datasource"
sed -i "s/user:.*/user: $adminUserName/" $GRAFANA_DATASOURCE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/password:.*/password: $adminPassword/" $GRAFANA_DATASOURCE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
echo "* Configure telegraf influxdb connection"
sed -i "s/username =.*/username = \"$adminUserName\"/" $TELEGRAF_CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/password =.*/password = \"$adminPassword\"/" $TELEGRAF_CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH

mkdir -p containers-datas
echo "* Initialise directory read/write rights"
chmod 777 -R containers-datas >> $INSTALL_LOG_FILE_PATH 2>&1
chmod 777 -R containers-confs >> $INSTALL_LOG_FILE_PATH 2>&1

read -e -p "* Download and create containers (yes/no) : [yes]" downloadCreateContainers
if [ $downloadCreateContainers = "yes"  ] || [ $downloadCreateContainers = "YES"  ]; then
    downloadCreateContainers=true
    echo "* Create containers (It can takes about 30min)"
    docker-compose up -d >> $INSTALL_LOG_FILE_PATH 2>&1
    echo "* Initialise directory read/write rights"
    chmod 777 -R containers-datas >> $INSTALL_LOG_FILE_PATH 2>&1
    chmod 777 -R containers-confs >> $INSTALL_LOG_FILE_PATH 2>&1
elif [ $downloadCreateContainers = "no"  ] || [ $downloadCreateContainers = "NO"  ]; then
    downloadCreateContainers=false
else
    downloadCreateContainers=true
    echo "* Create containers (It can takes about 30min)"
    docker-compose up -d >> $INSTALL_LOG_FILE_PATH 2>&1
    echo "* Initialise directory read/write rights"
    chmod 777 -R containers-datas >> $INSTALL_LOG_FILE_PATH 2>&1
    chmod 777 -R containers-confs >> $INSTALL_LOG_FILE_PATH 2>&1
fi

if [ $downloadCreateContainers = true  ]; then
    echo "* Installation logs are avaliable in installLogs.log file"
    echo " "
    echo "* Publish MQTT message on \"influxdb\" topic on 1883 port and localhost or 127.0.0.1 IP adress"
    echo "* All \"influxdb\" topic message will be stored in \"db_metrics\" influxdb database"
    echo " "
    echo "* Access to grafana at http://[IP ADRESS]:3000"
    echo "* Access to portainer at http://[IP ADRESS]:9000"
    if [ $activateNodeRed = true  ]; then
        echo "* Access to node-red at http://[IP ADRESS]:1880"
    fi
else
    echo "* Configuration is OK"
    echo "* You can now customize the EdgeDockerStack/docker-compose.yml  and / or start it with docker-compose commands"
fi

echo "* Remove installation script"
cd ..
rm -R -f install.sh
