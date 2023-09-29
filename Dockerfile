FROM php:8.0-apache

RUN apt update && \
 apt clean
#RUN apt install -yqq libpq-dev
RUN apt-get update && apt-get install -y libpq-dev cron
RUN docker-php-ext-install pdo_mysql
RUN apt-get install -y \
 libwebp-dev \
 libjpeg62-turbo-dev \
 libpng-dev libxpm-dev \
 libfreetype6-dev

RUN docker-php-ext-configure gd \
 --with-gd \
 --with-webp-dir \
 --with-jpeg-dir \
 --with-png-dir \
 --with-zlib-dir \
 --with-xpm-dir \
 --with-freetype-dir


ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php --install-dir=/usr/local/bin --filename=composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
 zlib1g-dev \
 libzip-dev \
 unzip
RUN docker-php-ext-install zip


COPY composer.* /var/www/html
RUN composer install

COPY . /var/www/html

CMD ["apache2ctl", "-D","FOREGROUND"]
