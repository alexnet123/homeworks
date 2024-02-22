Домашнее задание к занятию 3. «MySQL» Вахрамеев А.В.

---

## Задача 1: Работа с Docker и MySQL

### Поднятие инстанса MySQL в Docker
```plaintext
root@sql2:/home/admin/mysql# docker compose up -d
```

```plaintext
root@sql2:/home/admin/mysql# docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS                                                  NAMES
a8d2eed451be   mysql:8   "docker-entrypoint.s…"   11 seconds ago   Up 6 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql-mysql-1
```

### Восстановления из бэкапа

```plaintext
root@sql2:/home/admin/mysql# cp /home/admin/bd-dev-homeworks/06-db-03-mysql/test_data/test_dump.sql backup/test_dump.sql
```


```plaintext
bash-4.4# mysql -u root -p < /backup/test_dump.sql 
Enter password: 
ERROR 1046 (3D000) at line 22: No database selected
bash-4.4# mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS test_db;"
bash-4.4# mysql -u root -p < /backup/test_dump.sql 

bash-4.4# mysql -u root -p
mysql> \h

mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'

```

### Команда для выдачи статуса БД и версия сервера БД
```plaintext
mysql> \s

mysql> \s
--------------
mysql  Ver 8.3.0 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		8
Current database:	
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.3.0 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			51 sec

Threads: 2  Questions: 6  Slow queries: 0  Opens: 119  Flush tables: 3  Open tables: 38  Queries per second avg: 0.117

```

### Получение списка таблиц и количество записей с price > 300
```plaintext
mysql> USE test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.04 sec)

```

## Задача 2: Создание пользователя

### Создание пользователя `test`
```plaintext
mysql> CREATE USER 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test-pass' 
    -> WITH MAX_QUERIES_PER_HOUR 100 
    -> PASSWORD EXPIRE INTERVAL 180 DAY 
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2 
    -> ATTRIBUTE '{"name": "James", "surname": "Pretty"}';
mysql> GRANT SELECT ON test_db.* TO 'test'@'%';
```

### Предоставление привилегий и проверка атрибутов
```plaintext
mysql> GRANT SELECT ON test_db.* TO 'test'@'%';
```
```plaintext
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+------+----------------------------------------+
| USER | HOST | ATTRIBUTE                              |
+------+------+----------------------------------------+
| test | %    | {"name": "James", "surname": "Pretty"} |
+------+------+----------------------------------------+
```

## Задача 3: Профилирование и оптимизация

### Включение профилирования и изменение движка таблицы
```plaintext
mysql> SET profiling = 1;
mysql> ALTER TABLE orders ENGINE = MyISAM;
mysql> ALTER TABLE orders ENGINE = InnoDB;
```

### Просмотр профилей запросов
```plaintext
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

## Задача 4: Изучение и изменение файла my.cnf

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
