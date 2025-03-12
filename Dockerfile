FROM php:8.1-apache

LABEL maintainer="Garcia MICHEL <garcia@soamichel.fr>"

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev unzip curl zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip intl \
    && a2enmod rewrite \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Определяем версию Dolibarr
ARG DOLI_VERSION=19.0.3

# Скачиваем и устанавливаем Dolibarr
RUN curl -fSL "https://github.com/Dolibarr/dolibarr/archive/${DOLI_VERSION}.tar.gz" -o dolibarr.tar.gz \
    && mkdir -p /tmp/dolibarr \
    && tar -xzf dolibarr.tar.gz --strip-components=1 -C /tmp/dolibarr \
    && mv /tmp/dolibarr/htdocs /var/www/html \
    && mkdir -p /var/www/documents /var/www/html/custom \
    && chown -R www-data:www-data /var/www/html /var/www/documents \
    && rm -rf /tmp/dolibarr dolibarr.tar.gz

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]
