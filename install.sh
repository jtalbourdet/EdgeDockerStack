#!/bin/bash


CONF_FILE_PATH=".env"
DOCKER_COMPOSE_FILE_PATH="docker-compose.yml"
DOCKER_CONF_FILE_PATH="/etc/docker/daemon.json"
INSTALL_LOG_FILE_PATH="installLogs.log"
TELEGRAF_CONF_FILE_PATH="containers-confs/files/telegraf/config/telegraf.conf"
GRAFANA_DATASOURCE_FILE_PATH="containers-confs/files/grafana/provisioning/datasources/datasource.yaml"
echo " "
echo "      ::::::::         :::   :::       ::::    :::       ::::::::: "
echo "    :+:    :+:       :+:+: :+:+:      :+:+:   :+:       :+:    :+: "
echo "   +:+             +:+ +:+:+ +:+     :+:+:+  +:+       +:+    +:+  "
echo "  :#:             +#+  +:+  +#+     +#+ +:+ +#+       +#+    +:+   "
echo " +#+   +#+#      +#+       +#+     +#+  +#+#+#       +#+    +#+    "
echo "#+#    #+#      #+#       #+#     #+#   #+#+#       #+#    #+#     "
echo "########       ###       ###     ###    ####       #########       "
echo ""
echo " GMND-Boilerplate intallation from https://github.com/Talbourdet/GMND-Boilerplate " 
echo " "


echo "* Download GMND repository"
wget https://github.com/Talbourdet/GMND-Boilerplate/archive/master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
echo "* Unzip GMND content"
unzip master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
rm master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
chmod 777 -R GMND-Boilerplate-master >> $INSTALL_LOG_FILE_PATH 2>&1

mv $INSTALL_LOG_FILE_PATH GMND-Boilerplate-master/$INSTALL_LOG_FILE_PATH
cd GMND-Boilerplate-master


if [ -x "$(command -v docker)" ]; then
    echo "* Docker already installed"
else
    echo "* Docker ipk download"
    wget https://github.com/WAGO/docker-ipk/releases/download/v1.0.3/docker_19.03.13_armhf.ipk >> $INSTALL_LOG_FILE_PATH 2>&1
    echo "* Docker ipk installation"
    opkg install docker_19.03.13_armhf.ipk >> $INSTALL_LOG_FILE_PATH 2>&1
    rm docker_19.03.13_armhf.ipk >> $INSTALL_LOG_FILE_PATH 2>&1
fi

echo "* Stop Docker daemon"
/etc/init.d/dockerd stop >> $INSTALL_LOG_FILE_PATH 2>&1
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
    sed -i "s/\"data-root\":\"\/.*\/docker\",/\"data-root\":\"\/media\/$sdVolumeName\/docker\",/" $DOCKER_CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
fi
echo "* Start Docker daemon"
/etc/init.d/dockerd start >> $INSTALL_LOG_FILE_PATH 2>&1
if [ -x "$(command -v docker-compose)" ]; then
    echo "* Docker-compose already installed"
else
    echo "* Docker-compose ipk download"
    wget https://github.com/WAGO/docker-compose-ipk/raw/master/docker_compose_1.21.1_armhf.ipk >> $INSTALL_LOG_FILE_PATH 2>&1
    echo "* Docker-compose ipk installation"
    opkg install docker_compose_1.21.1_armhf.ipk    >> $INSTALL_LOG_FILE_PATH 2>&1
    rm docker_compose_1.21.1_armhf.ipk              >> $INSTALL_LOG_FILE_PATH 2>&1
fi

echo "* Create configuration directory \"containers-confs\""
cp -r containers-confs-template containers-confs    >> $INSTALL_LOG_FILE_PATH 2>&1
echo "* Create configuration file \".env\""
cp .env-template .env                               >> $INSTALL_LOG_FILE_PATH 2>&1

read -p "* Activate node-red container (yes/no) : [no]" activateNodeRed
if [ $activateNodeRed = "yes"  ] || [ $activateNodeRed = "YES"  ]; then
    echo "* Activate node-red container"
    sed -i "s/  # node-red-service:/  node-red-service:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   image: nodered\/node-red:\${NODERED_VERSION}/    image: nodered\/node-red:\${NODERED_VERSION}/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   volumes:/    volumes:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #     - .\/containers-confs\/files\/node-red\/config:\/data/      - .\/containers-confs\/files\/node-red\/config:\/data/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   ports:/    ports:/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #     - 1880:1880/      - 1880:1880/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
    sed -i "s/  #   restart: unless-stopped/    restart: unless-stopped/" $DOCKER_COMPOSE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
elif [ $activateNodeRed = "no"  ] || [ $activateNodeRed = "NO"  ]; then
    echo "* Desactivate node-red container"
else
    echo "* Desactivate node-red container"
fi

read -p "* Create Admin username:" adminUserName
read -p "* Create Admin password:" adminPassword

echo "* Configure influxdb username and password"
sed -i "s/GENERIC_ADMIN_USER=.*/GENERIC_ADMIN_USER=$adminUserName/" $CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/GENERIC_ADMIN_PASSWORD=.*/GENERIC_ADMIN_PASSWORD=$adminPassword/" $CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH

echo "* Configure grafana influxdb datasource"
sed -i "s/user:.*/user: $adminUserName/" $GRAFANA_DATASOURCE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/password:.*/password: $adminPassword/" $GRAFANA_DATASOURCE_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
echo "* Configure telegraf influxdb connection"
sed -i "s/username =.*/username = \"$adminUserName\"/" $TELEGRAF_CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH
sed -i "s/password =.*/password = \"$adminPassword\"/" $TELEGRAF_CONF_FILE_PATH 2>> $INSTALL_LOG_FILE_PATH

mkdir containers-datas
chmod 777 -R containers-datas >> $INSTALL_LOG_FILE_PATH 2>&1

echo "* Create containers"
docker-compose -f "docker-compose.yml" up -d --build >> $INSTALL_LOG_FILE_PATH 2>&1

chmod 777 -R containers-datas >> $INSTALL_LOG_FILE_PATH 2>&1

echo "* Installation logs are avaliable in installLogs.log file"
echo "* You can now publish your MQTT message on the influxdb\/ topic and visualize them in Grafana from the db_metrics database"


cd ..
rm install.sh
