FROM php:8.1-apache

LABEL maintainer="Garcia MICHEL <garcia@soamichel.fr>"

# Определяем версию Dolibarr
ARG DOLI_VERSION=19.0.3

# Переменные окружения
ENV DOLI_DB_TYPE=mysqli
ENV DOLI_DB_HOST=mysql.railway.internal
ENV DOLI_DB_PORT=3306
ENV DOLI_DB_NAME=railway
ENV DOLI_DB_USER=root
ENV DOLI_DB_PASSWORD=DVlqYepFOatWQCebyatDqqXnMdzgIVrx

# Устанавливаем зависимости PHP
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev unzip curl \
    && docker-php-ext-install mysqli pdo_mysql gd zip intl \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и распаковываем Dolibarr (фикс ошибки с путями)
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

