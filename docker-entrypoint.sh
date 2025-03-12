#!/bin/bash
set -e

# Инициализируем MySQL (если он не настроен)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Инициализация MySQL..."
    mysqld --initialize-insecure
    echo "MySQL инициализирован."
fi

# Запускаем MySQL сервер в фоновом режиме
echo "Запуск MySQL..."
mysqld_safe --skip-networking &
sleep 5  # Даем MySQL время на запуск

# Проверяем, создана ли база данных
if [ ! -d "/var/lib/mysql/dolibarr" ]; then
    echo "Создаём базу данных Dolibarr..."
    mysql -uroot -e "CREATE DATABASE IF NOT EXISTS dolibarr;"
    mysql -uroot -e "CREATE USER IF NOT EXISTS 'dolibarr'@'localhost' IDENTIFIED BY 'dolibarr';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON dolibarr.* TO 'dolibarr'@'localhost';"
    mysql -uroot -e "FLUSH PRIVILEGES;"
fi

# Запускаем Apache
echo "Запуск Apache..."
exec apache2-foreground
