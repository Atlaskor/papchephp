FROM php:8.3-apache

# Install system dependencies for PHP extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        zip \
        unzip \
        libonig-dev \
        libxml2-dev \
        curl && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j"$(nproc)" \
        gd \
        pdo \
        pdo_mysql \
        mysqli \
        mbstring \
        zip \
        xml \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite
