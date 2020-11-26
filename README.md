# GMND-Boilerplate

## Indroduction

GMND-Boilerplate is a template for working with Grafana, Influx, Mqtt an d Node-red on Docker. 

The objective of this repository is to facilitate deployment on WAGO PFC200 and Touch-Panels [WAGO-Contact](https://www.wago.com).

The [Portainer](https://www.portainer.io/) utility is also integrated into this project in order to facilitate the administration and monitoring of containers
## Prerequisite

Docker and Docker-compose must have been installed

### Wago Hardawares (PFC200 and TP600)

Follow the explanations of these two repositories in order to correctly install docker and docker-compose on your target wago

Readme [WAGO/docker-ipk](https://github.com/WAGO/docker-ipk)

Readme [WAGO/docker-compose-ipk](https://github.com/WAGO/docker-compose-ipk)

## Installation

Make sure you have your equipment connected to the network with internet access (do not forget to configure the DNS and the gateway address)

Connect to the equipment in SSH (use for example putty on windows) and go preferably in the sd card.

```
cd /media/sd
```

Download and run the installation script

```
wget -O install.sh https://raw.githubusercontent.com/Talbourdet/GMND-Boilerplate/master/install.sh

/bin/bash install.sh
```
Let the script do and answer the questions. the complete installation can take between 15 and 30 minutes depending on the speed of your connection.

As soon as the installation is complete, the various services are accessible according to the following URLs

* Grafana at http://[IP ADRESS]:3000
* Portainer at http://[IP ADRESS]:9000
* Node-red at http://[IP ADRESS]:1880

## Detailed information

### Docker containers data persistence

All the persitents files are strored in the "containers-datas" directory who is created at the first startup. Each container has its own directory inside "container-datas".

### Configuring Docker containers

The version of the images used as well as the identifiers of the influxdb database can be defined in the .env configuration file

The configuration of the other tools is in the "containers-confs/files" directory. You will find there the configuration files (grafan.ini, telegraf.conf, setting.json...).

## Contributing

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request :D
## Credits

Lead Developer - Julien TALBOURDET (@Talbourdet)

## Liscence

The MIT License (MIT)