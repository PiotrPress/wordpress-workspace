# WordPress Workspace

This library is [WordPress](https://wordpress.org/) development environment based on [Docker](https://www.docker.com/) which uses [Apache](https://httpd.apache.org/) web server, [MariaDB](https://mariadb.org/) database, [PHPMyAdmin](https://www.phpmyadmin.net/), [Composer](https://getcomposer.org/) and [WP-CLI](https://wp-cli.org/).

**NOTE:** This environment is designed for development purposes only and should not be used in production.

## Setup

```shell
$ ./bin/setup
```

## Usage

### Start Docker

```shell
$ ./bin/start
```

### View Website

[https://localhost](https://localhost)

### PHPMyAdmin

[http://localhost:8080](http://localhost:8080)

### Stop Docker

```shell
$ ./bin/stop
```

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## License

[MIT](license.txt)