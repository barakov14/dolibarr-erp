<?php
// URL твоего приложения на Railway (замени на свой URL)
$dolibarr_main_url_root='';

// Абсолютный путь к каталогу htdocs (обычно Dolibarr сам подхватит)
$dolibarr_main_document_root=__DIR__.'/..';

// Путь для документов (можно оставить так, Dolibarr создаст автоматически)
$dolibarr_main_data_root=realpath(__DIR__.'/../../documents');

// База данных на Railway (используй MYSQLPUBLICURL)
$dolibarr_main_db_type='mysqli';
$dolibarr_main_db_host='containers-us-west-124.railway.app'; // 👈 замени на host из MYSQL_PUBLIC_URL
$dolibarr_main_db_port='3306'; // 👈 замени на порт из MYSQL_PUBLIC_URL
$dolibarr_main_db_name='railway';
$dolibarr_main_db_user='root';
$dolibarr_main_db_pass='DVqIwN5v08W5pJ2w'; // 👈 пароль отсюда MYSQLPASSWORD

// Кодировка (рекомендуется)
$dolibarr_main_db_character_set='utf8mb4';
$dolibarr_main_db_collation='utf8mb4_unicode_ci';

// Безопасность
$dolibarr_main_force_https='0';

// Стандартные параметры
$dolibarr_main_authentication='dolibarr';
$dolibarr_main_db_prefix='llx_';

// Уникальный ID (можно оставить как есть)
$dolibarr_main_instance_unique_id='84b5bc91f83b56e458db71e0adac2b62';
