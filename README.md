# Indroduction

GMND-Boilerplate is a template for working with Grafana, MariaDB and Python 3.5 on Docker. 
The [Portainer](https://www.portainer.io/) utility is also integrated into this project in order to facilitate the administration and monitoring of containers

## Prerequisites

Before using GMND-Boilerplate, you must install the following software.

* Python >= 3.5
* Pip >=20.0.2
* Docker and Docker-compose

## Installation

Clone the repository and type the command below in your preferred terminal.

```
npm install
```

## Run in developpment mode

Start the MariaDB and Grafana instances conatainers.

```
docker-compose -f "docker-compose.yml" up -d --build
```

Start in dev mode your Python 3.5 application.

```
python main.py
```

## Run in production mode

Uncomment the folowing lines in the docker-compose.yml file.

```
#python-service:
  #   build:
  #     context: ./docker
  #     dockerfile: dockerfile-python
  #   volumes:
  #     - .:/usr/src/app
  #   restart: unless-stopped
  #   command: python ./main.py
```

Start the MariaDB, Grafana and Python 3.5 instances conatainers.

```
docker-compose -f "docker-compose.yml" up -d --build
```

## Docker container data persistence

### MariaDB

A v mariadb volume is created for the persistence of mariadb data

### Grafana

A v_grafana volume is created for the persistence of grafana data

### Portainer

A v_portainer volume is created for the persistence of portainer data

### Python

This project directory is mounted as a volume for the Python 3.5 container

## Python project

The entry point for the python project is the main.py file. This project integrates the ORM [SQLAlchemy](https://www.sqlalchemy.org/) and the client OPC-UA [FreeOpcUa/Python OPC-UA](https://github.com/FreeOpcUa/python-opcua).

In order to configure the connections you can rename the file 'template.config.yml' to 'config.yml' and enter the different connection parameters there.

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