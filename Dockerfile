FROM wordpress:php8.3-fpm

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    apache2 \
    libapache2-mod-fcgid \
    bash \
    openssh-client \
    ssl-cert \
    cron \
    supervisor \
    mc \
    nano \
    zip \
    unzip \
    less \
    git \
    mariadb-client

RUN a2enmod  \
    rewrite \
    expires \
    headers \
    ssl \
    proxy_fcgi \
    setenvif

RUN a2ensite \
    default-ssl

RUN mkdir -p /run/php
RUN chmod 0755 /run/php
RUN chown www-data:www-data /run/php
RUN echo 'listen.owner = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf
RUN echo 'listen.group = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf
RUN echo 'listen.mode = 0660' >> /usr/local/etc/php-fpm.d/zz-docker.conf
RUN sed -i 's|listen = 9000|listen = /run/php/php-fpm.sock|' /usr/local/etc/php-fpm.d/zz-docker.conf
RUN cat <<'EOF' > /etc/apache2/conf-available/php-fpm.conf
<IfModule mod_proxy_fcgi.c>
    <FilesMatch "\.php$">
        SetHandler "proxy:unix:/run/php/php-fpm.sock|fcgi://localhost"
    </FilesMatch>
</IfModule>
EOF
RUN a2enconf \
    php-fpm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/Options\s\+Indexes/Options/' /etc/apache2/apache2.conf
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
USER www-data

RUN composer config -g allow-plugins.piotrpress/wordpress-composer true --quiet --no-interaction
RUN composer global require piotrpress/wordpress-composer --quiet --no-interaction

USER root

RUN echo '* * * * * /usr/local/bin/php /usr/local/bin/wp cron event run --due-now --path=/var/www/html/wp-core/ >> /dev/null 2>&1' | crontab -u www-data -
RUN echo '[program:cron]\ncommand=cron -f\nautostart=true\nautorestart=true\n' > /etc/supervisor/conf.d/cron.conf
RUN echo '[program:php]\ncommand=php-fpm -F\nautostart=true\nautorestart=true\n' > /etc/supervisor/conf.d/php.conf
RUN echo '[program:apache]\ncommand=apache2ctl -D FOREGROUND\nautostart=true\nautorestart=true\n' > /etc/supervisor/conf.d/apache.conf

VOLUME /var/www/html

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-n", "-c", "/etc/supervisor/supervisord.conf"]