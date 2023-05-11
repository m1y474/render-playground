FROM php:7.4-apache

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        openssl libssl-dev \
        libxml2-dev \
        unzip \
        libonig-dev \
        libmagickwand-dev \
    && docker-php-ext-install -j$(nproc) iconv pdo_mysql mysqli mbstring xml tokenizer zip bcmath \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install exif \
    && cd /etc/apache2/mods-enabled \
    && ln -snf ../mods-available/rewrite.load

VOLUME ["/src"]

WORKDIR /var/www/html
COPY ./src .
COPY ./docker/apache2/sites-available /etc/apache2/sites-available
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html
