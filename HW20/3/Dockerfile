FROM php:8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable pdo pdo_mysql \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       libmemcached-dev zlib1g-dev libssl-dev
RUN yes '' | pecl install -f memcached-3.2.0 \
    && docker-php-ext-enable memcached
# Enable Apache mod_rewrite
RUN a2enmod rewrite

EXPOSE 80
