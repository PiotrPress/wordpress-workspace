FROM php:8.2-apache

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl.conf

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    bash \
    openssh-client \
    ssl-cert \
    mc \
    nano \
    zip \
    unzip \
    git \
    less \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    libzip-dev

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    zip

RUN	docker-php-ext-configure gd \
    --with-jpeg

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chown 1000:1000 /usr/local/bin/wp

RUN mkdir -p /tmp/composer && chown -R 1000:1000 /tmp/composer
ENV COMPOSER_HOME=/tmp/composer

USER 1000
RUN composer config -g allow-plugins.piotrpress/wordpress-composer true --quiet --no-interaction
RUN composer global require piotrpress/wordpress-composer --quiet --no-interaction

USER root

VOLUME /var/www/html

EXPOSE 80
EXPOSE 443

ENTRYPOINT apache2-foreground