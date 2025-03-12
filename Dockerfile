# Base PHP 8.1 image with Apache
FROM php:8.3-apache

# Install system dependencies for PHP extensions and tools
RUN apt-get update && apt-get install -y \
    mariadb-server mariadb-client \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    libzip-dev zlib1g-dev libicu-dev libonig-dev unzip curl \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip intl mbstring \
  && a2enmod rewrite \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Use production PHP configurations for better performance
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Set Dolibarr version environment variable
ENV DOLIBARR_VERSION=21.0.0

# Download and extract Dolibarr into the web root
RUN curl -L "https://sourceforge.net/projects/dolibarr/files/Dolibarr%20ERP-CRM/${DOLIBARR_VERSION}/dolibarr-${DOLIBARR_VERSION}.zip/download" -o /tmp/dolibarr.zip \ 
  && unzip /tmp/dolibarr.zip -d /tmp \ 
  && mv /tmp/dolibarr-${DOLIBARR_VERSION}/htdocs/* /var/www/html/ \ 
  && rm -rf /tmp/dolibarr-${DOLIBARR_VERSION} /tmp/dolibarr.zip

# Set correct file permissions for Apache
RUN chown -R www-data:www-data /var/www/html

# Expose HTTP port
EXPOSE 80

COPY conf.php /backup/conf.php
RUN touch /backup/install.lock

# Копируем и даем права на скрипт запуска MySQL + Apache
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Entrypoint and CMD to start Apache and serve Dolibarr
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
