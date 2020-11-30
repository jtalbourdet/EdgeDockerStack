#!/bin/bash

CONF_FILE_PATH=".env"
INSTALL_LOG_FILE_PATH="installLogs.log"



echo "* Download from repository"
wget https://github.com/Talbourdet/EdgeDockerStack/archive/master.zip >> $INSTALL_LOG_FILE_PATH 2>&1

echo "* Unzip content"
unzip master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
rm master.zip >> $INSTALL_LOG_FILE_PATH 2>&1
mv -f EdgeDockerStack-master EdgeDockerStack
mv $INSTALL_LOG_FILE_PATH EdgeDockerStack/$INSTALL_LOG_FILE_PATH

echo "* Initialise Node-red configuration"
cp -R -f EdgeDockerStack/containers-confs/files/node-red EdgeDockerStack/containers-datas/

echo "* Initialise directory read/write rights"
chmod 777 -R EdgeDockerStack >> $INSTALL_LOG_FILE_PATH 2>&1

echo "* Remove installation script"
rm -R -f install.sh
