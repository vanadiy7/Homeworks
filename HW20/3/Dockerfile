FROM php:8.2-apache

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git
RUN docker-php-ext-install pdo pdo_mysql    

WORKDIR /var/www/html

RUN git clone https://github.com/qyjohn/simple-lamp
RUN chmod -R 777 . \
&& a2enmod rewrite

EXPOSE 80
