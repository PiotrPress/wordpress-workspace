# WordPress Workspace

This library is [WordPress](https://wordpress.org/) development environment based on [Docker](https://www.docker.com/) which uses [OpenLiteSpeed](https://openlitespeed.org/) web server, [MariaDB](https://mariadb.org/) database and [Composer](https://getcomposer.org/) dependency manager.

**NOTE:** This environment is designed for development purposes only and should not be used in production.

## Setup

```shell
$ ./bin/setup
```

## Usage

### Start Docker containers

```shell
$ ./bin/start
```

### View WordPress website

[https://localhost](https://localhost)

### Execute commands

```shell
$ ./bin/exec <container> <user>
```

### Stop Docker containers

```shell
$ ./bin/stop
```

## Requirements

[Docker](https://www.docker.com/)

## License

[MIT](license.txt)