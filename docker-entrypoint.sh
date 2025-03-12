# #!/bin/bash
# set -e

# # Создаём конфиг Dolibarr (используем переменные окружения)
# if [ ! -f /var/www/html/conf/conf.php ]; then
#     echo "Создаём файл конфигурации conf.php..."

#     cat <<EOL > /var/www/html/conf/conf.php
# <?php
# \$dolibarr_main_url_root='https://dolibarr-erp.onrender.com';
# \$dolibarr_main_document_root='/var/www/html';
# \$dolibarr_main_data_root='/var/www/documents';

# \$dolibarr_main_db_type='mysqli';
# \$dolibarr_main_db_host='${MYSQLHOST}';
# \$dolibarr_main_db_port='${MYSQLPORT}';
# \$dolibarr_main_db_name='${MYSQLDATABASE}';
# \$dolibarr_main_db_user='${MYSQLUSER}';
# \$dolibarr_main_db_pass='${MYSQLPASSWORD}';

# \$dolibarr_main_db_character_set='utf8mb4';
# \$dolibarr_main_db_collation='utf8mb4_unicode_ci';

# \$dolibarr_main_authentication='dolibarr';
# \$dolibarr_main_db_prefix='llx_';

# \$dolibarr_main_force_https=1;
# \$dolibarr_main_instance_unique_id='84b5bc91f83b56e458db71e0adac2b62';
# ?>
# EOL

#     echo "Файл conf.php создан успешно!"
# fi

# # Удаляем папку установки (для безопасности)
# if [ -d "/var/www/html/install" ]; then
#     echo "Удаляем папку установки..."
#     rm -rf /var/www/html/install
# fi

# # Запускаем Apache
# echo "Запуск Apache..."
# exec apache2-foreground
