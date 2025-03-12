FROM php:8.1-apache

# Устанавливаем зависимости PHP и расширения
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev unzip \
    && docker-php-ext-install mysqli pdo_mysql gd \
    && docker-php-ext-enable mysqli pdo_mysql gd \
    && a2enmod rewrite

# Включаем mod_rewrite
RUN a2enmod rewrite

# Копируем код Dolibarr в контейнер
COPY . /var/www/html/

# Создаём необходимые папки, если они отсутствуют
RUN mkdir -p /var/www/html/documents /var/www/html/htdocs/conf \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/documents \
    && chmod -R 777 /var/www/html/htdocs/conf

# Устанавливаем правильный DocumentRoot
RUN sed -i 's|/var/www/html|/var/www/html/htdocs|g' /etc/apache2/sites-available/000-default.conf

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]
