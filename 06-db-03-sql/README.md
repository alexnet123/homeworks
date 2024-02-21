Домашнее задание к занятию 3. «MySQL» Вахрамеев А.В.

---

## Задача 1: Работа с Docker и MySQL

### Поднятие инстанса MySQL в Docker

```plaintext
root@sql2:/home/admin/mysql# docker compose up -d
```

### Проверка запущенных контейнеров

```plaintext
root@sql2:/home/admin/mysql# docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS                                                  NAMES
a8d2eed451be   mysql:8   "docker-entrypoint.s…"   11 seconds ago   Up 6 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql-mysql-1
```

## Задача 2: Восстановление из бэкапа

### Копирование бэкапа в контейнер

```plaintext
root@sql2:/home/admin/mysql# cp /home/admin/bd-dev-homeworks/06-db-03-mysql/test_data/test_dump.sql backup/test_dump.sql
```

### Восстановления из бэкапа

```plaintext
bash-4.4# mysql -u root -p < /backup/test_dump.sql 
Enter password: 
ERROR 1046 (3D000) at line 22: No database selected
bash-4.4# mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS test_db;"
bash-4.4# mysql -u root -p test_db < /backup/test_dump.sql
```

## Задача 3: Создание пользователя

### Создание пользователя и предоставление привилегий

```plaintext
mysql> CREATE USER 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test-pass' 
    -> WITH MAX_QUERIES_PER_HOUR 100 
    -> PASSWORD EXPIRE INTERVAL 180 DAY 
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2 
    -> ATTRIBUTE '{"name": "James", "surname": "Pretty"}';
mysql> GRANT SELECT ON test_db.* TO 'test'@'%';
```

### Проверка атрибутов пользователя

```plaintext
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+------+----------------------------------------+
| USER | HOST | ATTRIBUTE                              |
+------+------+----------------------------------------+
| test | %    | {"name": "James", "surname": "Pretty"} |
+------+------+----------------------------------------+
```

## Задача 4: Профилирование и оптимизация

### Включение профилирования и изменение движка таблицы

```plaintext
mysql> SET profiling = 1;
mysql> ALTER TABLE orders ENGINE = MyISAM;
mysql> ALTER TABLE orders ENGINE = InnoDB;
```



### Просмотр профилей запросов

```plaintext
mysql> SHOW PROFILES;
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                                                                                                 |
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|        1 | 0.00125725 | SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db'                                                                                               |
|        2 | 0.00060600 | ALTER TABLE _ ENGINE = MyISAM                                                                                                                                                         |
|        3 | 0.00049700 | ALTER TABLE _ ENGINE = InnoDB                                                                                                                                                         |
|        4 | 0.00008400 | mysql> SET profiling = 1                                                                                                                                                              |
|        5 | 0.00006950 | Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db'                                       |
|        6 | 0.00008125 | +------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)

mysql> ALTER TABLE _ ENGINE = MyISAM |
|        7 | 0.03031450 | ALTER TABLE orders ENGINE = MyISAM                                                                                                                                                    |
|        8 | 0.06398025 | ALTER TABLE orders ENGINE = InnoDB                                                                                                                                                    |
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
8 rows in set, 1 warning (0.01 sec)

```

## Работа с файлом конфигурации

### Поиск и просмотр файла конфигурации

```plaintext
bash-4.4# find / -name my.cnf
/etc/my.cnf
```

### Файл `my.cnf`

```plaintext
[mysqld]

# Изменения для оптимизации производительности и использования ресурсов
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 600M # 30% от 2ГБ
innodb_log_file_size = 100M

default-authentication-plugin = mysql_native_password
host-cache-size = 0
skip-name-resolve
datadir = /var/lib/mysql
socket = /var/run/mysqld/mysqld.sock
secure-file-priv = /var/lib/mysql-files
user = mysql

pid-file = /var/run/mysqld/mysqld.pid

[client]
socket = /var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/

```

---
