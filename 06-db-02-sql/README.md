# Домашнее задание к занятию 2. «SQL» Вахрамеев А.В.

Задача 1: 

---

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
Приведите получившуюся команду или docker-compose-манифест.

```
version: '3.1'

services:
  postgres:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test
    volumes:
      - ./pgdata:/var/lib/postgresql/data
      - ./pgbackups:/backups
    ports:
      - "5432:5432"

volumes:
  pgdata:
  pgbackups:

```

Задача 2: 

---

Создайте пользователя test-admin-user и БД test_db;

```
CREATE USER "test-admin-user" WITH PASSWORD 'password';
CREATE DATABASE test_db;
GRANT ALL PRIVILEGES ON DATABASE test_db TO "test-admin-user";
```

В БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);

```
\c test_db
CREATE TABLE orders  (id SERIAL PRIMARY KEY,name VARCHAR(255),price INT);
CREATE TABLE clients (id SERIAL PRIMARY KEY,last_name VARCHAR(255),country VARCHAR(255),order_id INT,FOREIGN KEY (order_id) REFERENCES orders(id));
CREATE INDEX ON clients(country);
```

Предоставление привилегий test-admin-user:

```
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "test-admin-user";
```

Создание пользователя test-simple-user и предоставление прав:

```
CREATE USER "test-simple-user" WITH PASSWORD 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
```

```
Список БД можно получить командой: \l

test_db=# \l
                                  List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    |     Access privileges      
-----------+-------+----------+------------+------------+----------------------------
 postgres  | test  | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | test  | UTF8     | en_US.utf8 | en_US.utf8 | =c/test                   +
           |       |          |            |            | test=CTc/test
 template1 | test  | UTF8     | en_US.utf8 | en_US.utf8 | =c/test                   +
           |       |          |            |            | test=CTc/test
 test      | test  | UTF8     | en_US.utf8 | en_US.utf8 | 
 test_db   | test  | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/test                  +
           |       |          |            |            | test=CTc/test             +
           |       |          |            |            | "test-admin-user"=CTc/test
(5 rows)


Описание таблиц можно получить командами: \d orders; \d clients;

test_db=# \d orders; \d clients;
                                    Table "public.orders"
 Column |          Type          | Collation | Nullable |              Default               
--------+------------------------+-----------+----------+------------------------------------
 id     | integer                |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying(255) |           |          | 
 price  | integer                |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)

                                     Table "public.clients"
  Column   |          Type          | Collation | Nullable |               Default               
-----------+------------------------+-----------+----------+-------------------------------------
 id        | integer                |           | not null | nextval('clients_id_seq'::regclass)
 last_name | character varying(255) |           |          | 
 country   | character varying(255) |           |          | 
 order_id  | integer                |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_country_idx" btree (country)
Foreign-key constraints:
    "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)


```

SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:
Cписок пользователей с правами над таблицами test_db:

```
 SELECT *                      
FROM information_schema.role_table_grants
WHERE table_catalog = 'test_db' AND table_schema = 'public';
 grantor |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
---------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 test    | test             | test_db       | public       | orders     | INSERT         | YES          | NO
 test    | test             | test_db       | public       | orders     | SELECT         | YES          | YES
 test    | test             | test_db       | public       | orders     | UPDATE         | YES          | NO
 test    | test             | test_db       | public       | orders     | DELETE         | YES          | NO
 test    | test             | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 test    | test             | test_db       | public       | orders     | REFERENCES     | YES          | NO
 test    | test             | test_db       | public       | orders     | TRIGGER        | YES          | NO
 test    | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 test    | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 test    | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 test    | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 test    | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 test    | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 test    | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 test    | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 test    | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 test    | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 test    | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 test    | test             | test_db       | public       | clients    | INSERT         | YES          | NO
 test    | test             | test_db       | public       | clients    | SELECT         | YES          | YES
 test    | test             | test_db       | public       | clients    | UPDATE         | YES          | NO
 test    | test             | test_db       | public       | clients    | DELETE         | YES          | NO
 test    | test             | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 test    | test             | test_db       | public       | clients    | REFERENCES     | YES          | NO
 test    | test             | test_db       | public       | clients    | TRIGGER        | YES          | NO
 test    | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 test    | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 test    | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 test    | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 test    | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 test    | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 test    | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 test    | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 test    | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 test    | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 test    | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO

```

Задача 3: Наполнение таблиц данными и подсчет записей

---

Наполнение таблиц:

```
INSERT INTO orders (name, price) VALUES ('Шоколад', 10),('Принтер', 3000),('Книга', 500),('Монитор', 7000),('Гитара', 4000);
```
```
INSERT INTO clients (last_name, country) VALUES ('Иванов Иван Иванович', 'USA'),('Петров Петр Петрович', 'Canada'),('Иоганн Себастьян Бах', 'Japan'),('Ронни Джеймс Дио', 'Russia'),('Ritchie Blackmore', 'Russia');
```

Подсчет записей:

```
test_db=# SELECT COUNT(*) FROM orders;
 count 
-------
     5
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)

```

Задача 4: Связывание записей таблиц

---

```
test_db=# SELECT * FROM orders;
 id |  name   | price 
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

test_db=# SELECT * FROM clients;
 id |      last_name       | country | order_id 
----+----------------------+---------+----------
  1 | Иванов Иван Иванович | USA     |         
  2 | Петров Петр Петрович | Canada  |         
  3 | Иоганн Себастьян Бах | Japan   |         
  4 | Ронни Джеймс Дио     | Russia  |         
  5 | Ritchie Blackmore    | Russia  |         
(5 rows)

```

```

UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Книга') WHERE last_name = 'Иванов Иван Иванович';

UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Монитор') WHERE last_name = 'Петров Петр Петрович';

UPDATE clients SET order_id = (SELECT id FROM orders WHERE name = 'Гитара') WHERE last_name = 'Иоганн Себастьян Бах';


```


*Запрос для выдачи всех пользователей, совершивших заказ:

```
test_db=# SELECT c.last_name, o.name FROM clients c JOIN orders o ON c.order_id = o.id;
      last_name       |  name   
----------------------+---------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)

```

Задача 5: Анализ выполнения запроса

---

```
test_db=# EXPLAIN SELECT c.last_name, o.name FROM clients c JOIN orders o ON c.order_id = o.id;
                               QUERY PLAN                                
-------------------------------------------------------------------------
 Hash Join  (cost=11.57..24.20 rows=70 width=1032)
   Hash Cond: (o.id = c.order_id)
   ->  Seq Scan on orders o  (cost=0.00..11.40 rows=140 width=520)
   ->  Hash  (cost=10.70..10.70 rows=70 width=520)
         ->  Seq Scan on clients c  (cost=0.00..10.70 rows=70 width=520)
(5 rows)

```

Задача 6: Бэкап и восстановление БД

---

Создание бэкапа:

```
root@bcce772c4838:/# pg_dumpall -U test > /backups/backup.sql
root@bcce772c4838:/# ls backups/
backup.sql

root@bcce772c4838:/# exit
exit

root@sql2:/home/admin# docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                                              NAMES
bcce772c4838   postgres:12          "docker-entrypoint.s…"   19 minutes ago   Up 19 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp          admin-postgres-1
4347e249a574   dpage/pgadmin4:8.3   "/entrypoint.sh"         19 minutes ago   Up 19 minutes   443/tcp, 0.0.0.0:65113->80/tcp, :::65113->80/tcp   prnc_pgadmin

root@sql2:/home/admin# docker compose down
[+] Running 3/2
 ✔ Container admin-postgres-1  Removed                                                                                                 0.2s 
 ✔ Container prnc_pgadmin      Removed                                                                                                 1.0s 
 ✔ Network admin_default       Removed                                                                                                 0.1s 

root@sql2:/home/admin# ls pg
pgbackups/ pgdata/    pgsql/     
root@sql2:/home/admin# ls pgsql/
pgadmin

root@sql2:/home/admin# ls pgdata/
base	      pg_dynshmem    pg_logical    pg_replslot	 pg_stat      pg_tblspc    pg_wal		 postgresql.conf
global	      pg_hba.conf    pg_multixact  pg_serial	 pg_stat_tmp  pg_twophase  pg_xact		 postmaster.opts
pg_commit_ts  pg_ident.conf  pg_notify	   pg_snapshots  pg_subtrans  PG_VERSION   postgresql.auto.conf

root@sql2:/home/admin# rm -rf  pgdata/*

root@sql2:/home/admin# docker compose up -d
[+] Running 2/3
 ⠦ Network admin_default       Created                                                                                                 0.6s 
 ✔ Container prnc_pgadmin      Started                                                                                                 0.5s 
 ✔ Container admin-postgres-1  Started                                                                                                 0.6s 

root@sql2:/home/admin# docker ps -a
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                                              NAMES
a93f9b7788b1   postgres:12          "docker-entrypoint.s…"   32 seconds ago   Up 30 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp          admin-postgres-1
30b6716b6d91   dpage/pgadmin4:8.3   "/entrypoint.sh"         32 seconds ago   Up 31 seconds   443/tcp, 0.0.0.0:65113->80/tcp, :::65113->80/tcp   prnc_pgadmin

root@sql2:/home/admin# docker exec -it a93f9b7788b1 bash

root@a93f9b7788b1:/# psql -U test -d test_db < /backups/backup.sql
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "test_db" does not exist

root@a93f9b7788b1:/# psql -U test
psql (12.18 (Debian 12.18-1.pgdg120+2))
Type "help" for help.

test=# CREATE DATABASE test_db;
CREATE DATABASE
test=# \q

root@a93f9b7788b1:/# psql -U test -d test_db < /backups/backup.sql

test=# \c test_db
You are now connected to database "test_db" as user "test".
test_db=# SELECT * FROM orders;
 id |  name   | price 
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

test_db=# 


```
