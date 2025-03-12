FROM php:8.1-apache

LABEL maintainer="Garcia MICHEL <garcia@soamichel.fr>"

# Задай явно версию Dolibarr
ENV DOLI_VERSION 19.0.3

# Основные переменные окружения Dolibarr
ENV DOLI_INSTALL_AUTO 1
ENV DOLI_PROD 1
ENV DOLI_URL_ROOT ""
ENV DOLI_DB_TYPE mysqli
ENV DOLI_DB_HOST mysql.railway.internal
ENV DOLI_DB_PORT 3306
ENV DOLI_DB_NAME railway
ENV DOLI_DB_USER root
ENV DOLI_DB_PASSWORD DVlqYepFOatWQCebyatDqqXnMdzgIVrx

# PHP настройки
ENV PHP_INI_DATE_TIMEZONE 'UTC'
ENV PHP_INI_MEMORY_LIMIT 256M
ENV PHP_INI_UPLOAD_MAX_FILESIZE 10M
ENV PHP_INI_POST_MAX_SIZE 16M

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        curl unzip libfreetype6-dev libjpeg-dev libpng-dev libzip-dev libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo_mysql gd zip intl \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и распаковываем Dolibarr
RUN curl -fSL "https://github.com/Dolibarr/dolibarr/archive/${DOLI_VERSION}.tar.gz" -o dolibarr.tar.gz \
    && tar -xzvf ${DOLI_VERSION}.tar.gz -C /tmp \
    && mv /tmp/dolibarr-${DOLI_VERSION}/htdocs/* /var/www/html/ \
    && mkdir -p /var/www/documents \
    && chown -R www-data:www-data /var/www/html /var/www/documents

# Открываем порт
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]
