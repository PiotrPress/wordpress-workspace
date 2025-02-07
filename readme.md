# WordPress Workspace

This library is [WordPress](https://wordpress.org/) development environment based on [Docker](https://www.docker.com/) which uses [Apache](https://httpd.apache.org/) web server, [MariaDB](https://mariadb.org/) database, [PHPMyAdmin](https://www.phpmyadmin.net/), [Composer](https://getcomposer.org/) and [WP-CLI](https://wp-cli.org/).

**NOTE:** This environment is designed for development purposes only and should not be used in production.

## Install

1. Build image

```shell
$ ./bin/build
```

2. Run Docker

```shell
$ ./bin/run
```

3. Install dependencies

```shell
$ ./bin/install
```

## Usage

### Run

```shell
$ ./bin/run
```

### View

[https://localhost](https://localhost)

### Update

```shell
$ ./bin/install
```

### Console

```shell
$ ./bin/console
```

### Database

```shell
$ ./bin/database
```

### PHPMyAdmin

[http://localhost:8080](http://localhost:8080)

### Close

```shell
$ ./bin/close 
```

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## License

[MIT](license.txt)