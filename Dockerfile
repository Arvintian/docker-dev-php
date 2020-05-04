FROM php:7.2-apache-stretch
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) zip
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN a2enmod rewrite
RUN useradd arvin
# user mods conf
COPY user.conf /etc/apache2/mods-user-conf/user.conf
RUN echo "IncludeOptional /etc/apache2/mods-user-conf/*.conf" >> /etc/apache2/apache2.conf