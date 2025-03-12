FROM php:8.1-apache

# Устанавливаем зависимости PHP и расширения
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev unzip \
    && docker-php-ext-install mysqli pdo_mysql gd \
    && docker-php-ext-enable mysqli pdo_mysql gd \
    && a2enmod rewrite

# Включаем mod_rewrite и устанавливаем права
RUN a2enmod rewrite

# Копируем код Dolibarr в контейнер
COPY . /var/www/html/

# Устанавливаем правильные права
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/documents \
    && chmod -R 777 /var/www/html/htdocs/conf

# Устанавливаем DocumentRoot на htdocs
RUN sed -i 's|/var/www/html|/var/www/html/htdocs|g' /etc/apache2/sites-available/000-default.conf

# Открываем 80 порт
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]
