# Use the official PHP-FPM image
FROM php:8.2-fpm

# Install dependencies and Xdebug
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Enable display errors and set error log file
COPY ./php.ini /usr/local/etc/php/conf.d/

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy application code into the container
COPY ./app /var/www/html

# Expose ports
EXPOSE 9000

