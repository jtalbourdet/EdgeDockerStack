# Indroduction

GMND-Boilerplate is a template for working with Grafana, MariaDB and NodeJs/TypeScript on Docker.

## Prerequisites

Before using GMND-Boilerplate, you must install the following software.

* nodejs
* npm
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

Start in dev mode your Nodejs/TypeScript application.

```
npm run dev
```

## Run in production mode

Uncomment the folowing lines in the docker-compose.yml file.

```
# node-service:
  #   build:
  #     context: .
  #     args:
  #       - NODE_ENV=production
  #   volumes:
  #     - .:/usr/src/app
  #     - /usr/src/app/node_modules
  #   ports:
  #     # - 8888:8888
  #   restart: unless-stopped
  #   command: npm run prod
```

Start the MariaDB, Grafana and Nodejs instances conatainers.

```
docker-compose -f "docker-compose.yml" up -d --build
```

## Docker container data persistence

### MariaDB

A volume v mariadb is created for the persistence of mariadb data

### Grafana

A v_grafana volume is created for the persistence of grafana data

### Nodejs

This project directory is mounted as a volume for the Nodejs container

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
