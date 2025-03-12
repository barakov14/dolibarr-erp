#!/bin/bash
set -e

# Запускаем MySQL
service mysql start

# Настраиваем базу данных, если она не создана
if [ ! -d "/var/lib/mysql/dolibarr" ]; then
    echo "Создаём базу данных Dolibarr..."
    mysql -uroot -e "CREATE DATABASE dolibarr;"
    mysql -uroot -e "CREATE USER 'dolibarr'@'localhost' IDENTIFIED BY 'dolibarr';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON dolibarr.* TO 'dolibarr'@'localhost';"
    mysql -uroot -e "FLUSH PRIVILEGES;"
fi

# Запускаем Apache в фоне
apache2-foreground
