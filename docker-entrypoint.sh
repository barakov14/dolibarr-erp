#!/bin/bash
set -e

# Проверяем, установлен ли MySQL
if ! command -v mysqld &> /dev/null
then
    echo "Ошибка: MariaDB (MySQL) не установлен!"
    exit 1
fi

# Запускаем MariaDB
echo "Запуск MariaDB..."
service mariadb start

echo "Ждём запуск MariaDB..."
sleep 5  # Ждём 5 секунд, пока база полностью запустится

# Проверяем, создана ли база данных
if [ ! -d "/var/lib/mysql/dolibarr" ]; then
    echo "Создаём базу данных Dolibarr..."
    mysql -uroot -e "CREATE DATABASE IF NOT EXISTS dolibarr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    mysql -uroot -e "CREATE USER IF NOT EXISTS 'dolibarr'@'localhost' IDENTIFIED BY 'dolibarr';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON dolibarr.* TO 'dolibarr'@'localhost';"
    mysql -uroot -e "FLUSH PRIVILEGES;"
fi

# Запускаем Apache
echo "Запуск Apache..."
exec apache2-foreground
