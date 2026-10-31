FROM litespeedtech/openlitespeed:1.9.4-lsphp85@sha256:9775405e3b519048039aedd5af110cd78fcce9314d72f780c9a6412e5164095d

ENV TZ=Europe/Warsaw

RUN apt-get update && apt-get install -y sudo unzip zip less && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
ENV COMPOSER_HOME=/tmp

WORKDIR /var/www/vhosts/localhost/html

USER 1000

COPY wp-cli.yml /var/www/vhosts/localhost/html/wp-cli.yml
COPY .config.template /var/www/vhosts/localhost/html/.config.template
COPY composer.json /var/www/vhosts/localhost/html/composer.json

RUN composer config -g allow-plugins.piotrpress/wordpress-composer true --no-interaction
RUN composer global require piotrpress/wordpress-composer --no-interaction
RUN composer update --no-interaction

USER root

RUN sed -i 's#^\([[:space:]]*docRoot[[:space:]]*\)\$VH_ROOT/html/#\1$VH_ROOT/html/wp-core/#' /usr/local/lsws/conf/templates/docker.conf