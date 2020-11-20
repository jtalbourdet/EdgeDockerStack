# GMND-Boilerplate

## Indroduction

GMND-Boilerplate is a template for working with Grafana, Influx, Mqtt and optionnaliy (Node-red) on Docker. 

The objective of this repository is to facilitate development as well as deployment on ARMv7 platform (in my case I use it on the PFC200 and TouchPanel of the company [WAGO-Contact](https://www.wago.com/global/open-automation/modular-software)).

The [Portainer](https://www.portainer.io/) utility is also integrated into this project in order to facilitate the administration and monitoring of containers

## Prerequisites

Before using GMND-Boilerplate, you must install the following software.

* Docker
* Docker-compose
 
## Install on WAGO PFC200 or TouchPanel600

1. [Readme WAGO/docker-ipk](https://github.com/WAGO/docker-ipk)
2. [Readme WAGO/docker-compose-ipk](https://github.com/WAGO/docker-compose-ipk)

3. Place the GMND-Boilerplate directory at the root of the SD card (can do this with [fileZilla](https://filezilla-project.org/) for example in FTP / FTPS or SFTP)

## Run on WAGO PFC200 or TouchPanel600
  1. Start SSH Client e.g. [Putty](https://www.putty.org/)
      ```
      login as `root`
      password `wago`
      ```
  2. Go in the GMND-Boilerplate directory (at the root of the SD card)
      ```
      cd /media/sd/GMND-Boilerplate
      ```
  3. Start the conatainers.
      ```
      docker-compose -f "docker-compose.yml" up -d --build
      ```

## Docker containers data persistence

All the persitents files are strored in the "containers-datas" directory who is created at the first startup. Each container has its own directory inside "container-datas".

## Configuring Docker containers

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