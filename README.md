# WordPress Workspace

This library is [WordPress](https://wordpress.org/) website [Docker](https://www.docker.com/) template which uses [MariaDB](https://mariadb.org/) database and [Apache](https://httpd.apache.org/) web server.

**NOTE:** This environment is designed for development purposes only and should not be used in production.

## Install

1. Build image

```shell
$ docker compose build --pull --no-cache
```

2. Run Docker

```shell
$ docker compose up -d
```

3. Install dependencies

```shell
$ docker compose exec wordpress composer update
```

## Usage

### Run

```shell
$ docker compose up -d
```

### View

[https://localhost](https://localhost)

### Update

```shell
$ docker compose exec wordpress git pull && composer update
```

### Terminal

```shell
$ docker compose exec wordpress bash
```

### Database

```shell
$ docker compose exec database mariadb
```

### PHPMyAdmin

[http://localhost:8080](http://localhost:8080)

### Close

```shell
$ docker compose down --remove-orphans 
```

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## License

[MIT](license.txt)