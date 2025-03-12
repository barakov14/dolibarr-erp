<?php
// URL твоего приложения на Railway (замени на свой URL)
$dolibarr_main_url_root='https://dolibarr-erp.onrender.com/';

// Абсолютный путь к каталогу htdocs (обычно Dolibarr сам подхватит)
$dolibarr_main_document_root=__DIR__.'/..';

// Путь для документов (можно оставить так, Dolibarr создаст автоматически)
$dolibarr_main_data_root=realpath(__DIR__.'/../../documents');

// База данных на Railway (используй MYSQLPUBLICURL)
$dolibarr_main_db_type='mysqli';
$dolibarr_main_db_host=getenv('MYSQLHOST');
$dolibarr_main_db_port=getenv('MYSQLPORT');
$dolibarr_main_db_name=getenv('MYSQLDATABASE');
$dolibarr_main_db_user=getenv('MYSQLUSER');
$dolibarr_main_db_pass=getenv('MYSQLPASSWORD');

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
