# Домашнее задание к занятию 4. «PostgreSQL» Вахрамеев А.В.

### Задача 1

1. **Поднятие инстанса PostgreSQL с использованием Docker**:

```

docker compose up -d

```

2. **Подключение к БД PostgreSQL с использованием psql**:
```

root@sql2:/home/admin# docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED         STATUS         PORTS                                              NAMES
f4b345ed1202   dpage/pgadmin4:8.3   "/entrypoint.sh"         2 minutes ago   Up 2 minutes   443/tcp, 0.0.0.0:65113->80/tcp, :::65113->80/tcp   prnc_pgadmin
8244bfe88921   postgres:13          "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp          admin-postgres-1
root@sql2:/home/admin# docker exec -it 8244bfe88921 bash
root@8244bfe88921:/# 



```

3. **Управляющие команды в psql**:

Вывод списка БД: `\l` или `\list`

```
test=# \l
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges 
-----------+-------+----------+------------+------------+-------------------
 postgres  | test  | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | test  | UTF8     | en_US.utf8 | en_US.utf8 | =c/test          +
           |       |          |            |            | test=CTc/test
 template1 | test  | UTF8     | en_US.utf8 | en_US.utf8 | =c/test          +
           |       |          |            |            | test=CTc/test
 test      | test  | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

```

Подключение к БД: `\c [database_name]`

```
test=# \c
You are now connected to database "test" as user "test".

```

Вывод списка таблиц: `\dt`

```
test=# \dt
Did not find any relations.

```
Вывод описания содержимого таблиц: `\d [table_name]`

Выход из psql: `\q`

### Задача 2

1. **Создание БД test_database**:

```
test=# CREATE DATABASE test_database;
CREATE DATABASE

```

3. **Восстановление бэкапа БД в test_database**:

```
root@sql2:/home/admin# cp bd-dev-homeworks/06-db-04-postgresql/test_data/test_dump.sql pgbackups/test_dump.sql
root@sql2:/home/admin# docker exec -it 8244bfe88921 bash
root@8244bfe88921:/#
psql -U test -d test_database < /backups/test_dump.sql

```
```
test=# \c test_database
You are now connected to database "test_database" as user "test".
test_database=# 

```

5. **Операция ANALYZE**:

```
test_database=# ANALYZE VERBOSE;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
INFO:  analyzing "pg_catalog.pg_type"
INFO:  "pg_type": scanned 10 of 10 pages, containing 414 live rows and 0 dead rows; 414 rows in sample, 414 estimated total rows
INFO:  analyzing "pg_catalog.pg_foreign_table"
INFO:  "pg_foreign_table": scanned 0 of 0 pages, containing 0 live rows and 0 dead rows; 0 rows in sample, 0 estimated total rows
INFO:  analyzing "pg_catalog.pg_authid"
INFO:  "pg_authid": scanned 1 of 1 pages, containing 9 live rows and 0 dead rows; 9 rows in sample, 9 estimated total rows
INFO:  analyzing "pg_catalog.pg_statistic_ext_data"
INFO:  "pg_statistic_ext_data": scanned 0 of 0 pages, containing 0 live rows and 0 dead rows; 0 rows in sample, 0 estimated total rows
INFO:  analyzing "pg_catalog.pg_largeobject"
INFO:  "pg_largeobject": scanned 0 of 0 pages, containing 0 live rows and 0 dead rows; 0 rows in sample, 0 estimated total rows
INFO:  analyzing "pg_catalog.pg_user_mapping"
INFO:  "pg_user_mapping": scanned 0 of 0 pages, containing 0 live rows and 0 dead rows; 0 rows in sample, 0 estimated total rows
INFO:  analyzing "pg_catalog.pg_subscription"
INFO:  "pg_subscription": scanned 0 of 0 pages, containing 0 live rows and 0 dead rows; 0 rows in sample, 0 estimated total rows
INFO:  analyzing "pg_catalog.pg_attribute"
INFO:  "pg_attribute": scanned 53 of 53 pages, containing 2880 live rows and 1 dead rows; 2880 rows in sample, 2880 estimated total rows

```


6. **Поиск столбца с наибольшим средним значением размера элементов**:

```

test_database=# SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders' ORDER BY avg_width DESC LIMIT 1;
 attname | avg_width 
---------+-----------
 title   |        16
(1 row)


```

### Задача 3

**SQL-транзакция для разбиения таблицы orders**:
1. Создание двух новых таблиц (`orders_1` и `orders_2`) с такой же структурой, как и у `orders`.
2. Копирование данных в соответствующие таблицы в зависимости от условия цены.
3. Удаление или переименование оригинальной таблицы `orders`.

```
BEGIN;

CREATE TABLE orders_1 AS SELECT * FROM orders WHERE price > 499;
CREATE TABLE orders_2 AS SELECT * FROM orders WHERE price <= 499;

DROP TABLE orders;

COMMIT;
```

**Исключение ручного разбиения при проектировании**: Да, использование partitioned tables в PostgreSQL позволяет автоматически разбивать таблицу на части (партиции) по заданным критериям, что исключает необходимость ручного разбиения в будущем.

### Задача 4

**Доработка бекап-файла для добавления уникальности столбца title**:

```

test_database=# SELECT table_schema, table_name
FROM information_schema.columns
WHERE column_name = 'title'
      AND table_catalog = 'test_database';
 table_schema | table_name 
--------------+------------
 public       | orders_1
 public       | orders_2
(2 rows)

```

Чтобы добавить уникальное ограничение для столбца title в этих таблицах следует выполнить следующие SQL-команды:

```

Для таблицы orders_1:

ALTER TABLE orders_1 ADD CONSTRAINT title_unique_orders_1 UNIQUE (title);

Для таблицы orders_2:

ALTER TABLE orders_2 ADD CONSTRAINT title_unique_orders_2 UNIQUE (title);
```


**Создание бекапа БД test_database**:

```
pg_dump -U postgres test_database > /backups/test_database_backup.sql

```
