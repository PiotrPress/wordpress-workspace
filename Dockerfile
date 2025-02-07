FROM php:8.2-apache

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl
RUN a2ensite default-ssl

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
    libwebp-dev \
    libavif-dev \
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
    --with-jpeg \
    --with-webp \
    --with-avif

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chown www-data:www-data /usr/local/bin/wp

RUN mkdir -p /tmp/composer && chown www-data:www-data /tmp/composer
ENV COMPOSER_HOME=/tmp/composer

USER www-data

RUN composer config -g allow-plugins.piotrpress/wordpress-composer true --quiet --no-interaction
RUN composer global require piotrpress/wordpress-composer --quiet --no-interaction

USER root

VOLUME /var/www/html

EXPOSE 80
EXPOSE 443

ENTRYPOINT apache2-foreground