# Домашнее задание к занятию "`12.7. «Репликация и масштабирование. Часть 2`" - `Вахрамеев А.В.`

---

### Задание 1

Опишите основные преимущества использования масштабирования методами:

- активный master-сервер и пассивный репликационный slave-сервер; 
- master-сервер и несколько slave-серверов;
- активный сервер со специальным механизмом репликации — distributed replicated block device (DRBD);
- SAN-кластер.

*Дайте ответ в свободной форме.*

`Ответ:`

1. Повышение производительности и надежности системы. Активный master-сервер обеспечивает основную обработку запросов, а репликационный slave-сервер может быть использован для распределения нагрузки.

2. Уменьшение удаленного хранилища. Трафик, который отправляется на slave-сервер, может быть существенно уменьшен.

3. Возможность увеличить мощность системы. Использование нескольких slave-серверов позволяет увеличить мощность системы.

4. Защита от потерь данных. DRBD-механизм репликации позволяет создавать резервные копии данных, что уменьшает риск потерь.

5. Расширяемость системы. SAN-кластеры могут увеличивать хранилище, что дает большую гибкость системы.
---

### Задание 2


Разработайте план для выполнения горизонтального и вертикального шаринга базы данных. База данных состоит из трёх таблиц: 

- пользователи, 
- книги, 
- магазины (столбцы произвольно). 

Опишите принципы построения системы и их разграничение или разбивку между базами данных.

*Пришлите блоксхему, где и что будет располагаться. Опишите, в каких режимах будут работать сервера.* 

`Ответ:`

---

`К примеру можно взять такую БД`
```
CREATE DATABASE library;

USE library;

CREATE TABLE users ( user_id INTEGER PRIMARY KEY, username VARCHAR(255) );

CREATE TABLE books ( bookid INTEGER PRIMARY KEY, title VARCHAR(255), author VARCHAR(255), numberof_pages INTEGER );

CREATE TABLE stores ( storeid INTEGER PRIMARY KEY, name VARCHAR(255), address VARCHAR(255), phone VARCHAR(255), numberof_employees INTEGER );
```

### Вертикальный шардинг

`Проверь работу контейнеров`

```
root@mysql:/home/admin# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                               NAMES
9cefd13fbeea   mysql     "docker-entrypoint.s…"   16 minutes ago   Up 16 minutes   33060/tcp, 0.0.0.0:3003->3306/tcp   db_one
6d1e61b6ff9f   mysql     "docker-entrypoint.s…"   16 minutes ago   Up 16 minutes   33060/tcp, 0.0.0.0:3004->3306/tcp   db_two


root@mysql:/home/admin# docker network ls
NETWORK ID     NAME             DRIVER    SCOPE
15e51dc924ac   bridge           bridge    local
3590553b8bb2   g_mysql_db_net   bridge    local
1ed71962919c   host             host      local
d981a8ed5b44   none             null      local
root@mysql:/home/admin# docker container inspect -f '{{ .NetworkSettings.Networks.g_mysql_db_net.IPAddress }}' db_one
172.20.0.12
root@mysql:/home/admin# docker container inspect -f '{{ .NetworkSettings.Networks.g_mysql_db_net.IPAddress }}' db_two
172.20.0.15
root@mysql:/home/admin# 

```

`db one`

```
mysql -u root -p'pass' -h 172.20.0.12 -e "CREATE DATABASE library;"

mysql -u root -p'pass' -h 172.20.0.12 -e "USE library; CREATE TABLE users ( user_id INTEGER PRIMARY KEY, username VARCHAR(255) );"

mysql -u root -p'pass' -h 172.20.0.12 -e "USE library; 
CREATE TABLE stores ( storeid INTEGER PRIMARY KEY, name VARCHAR(255), address VARCHAR(255), phone VARCHAR(255), numberof_employees INTEGER );"
```


`db two`

```
mysql -u root -p'pass' -h 172.20.0.15 -e "CREATE DATABASE library;"

mysql -u root -p'pass' -h 172.20.0.15 -e "USE library; CREATE TABLE books ( bookid INTEGER PRIMARY KEY, title VARCHAR(255), author VARCHAR(255), numberof_pages INTEGER );"
```

### Горизонтальный шардинг
`db one`

```
mysql -u root -p'pass' -h 172.20.0.12 -e "CREATE DATABASE library;"

mysql -u root -p'pass' -h 172.20.0.12 -e "USE library; CREATE TABLE users ( user_id INTEGER PRIMARY KEY, username VARCHAR(255) );"

mysql -u root -p'pass' -h 172.20.0.12 -e "USE library; CREATE TABLE books ( bookid INTEGER PRIMARY KEY, title VARCHAR(255), author VARCHAR(255), numberof_pages INTEGER );"

mysql -u root -p'pass' -h 172.20.0.12 -e "USE library; CREATE TABLE stores ( storeid INTEGER PRIMARY KEY, name VARCHAR(255), address VARCHAR(255), phone VARCHAR(255), numberof_employees INTEGER );"
```
`db two`

```
mysql -u root -p'pass' -h 172.20.0.15 -e "CREATE DATABASE library;"

mysql -u root -p'pass' -h 172.20.0.15 -e "USE library; CREATE TABLE users ( user_id INTEGER PRIMARY KEY, username VARCHAR(255) );"

mysql -u root -p'pass' -h 172.20.0.15 -e "USE library; CREATE TABLE books ( bookid INTEGER PRIMARY KEY, title VARCHAR(255), author VARCHAR(255), numberof_pages INTEGER );"

mysql -u root -p'pass' -h 172.20.0.15 -e "USE library; CREATE TABLE stores ( storeid INTEGER PRIMARY KEY, name VARCHAR(255), address VARCHAR(255), phone VARCHAR(255), numberof_employees INTEGER );"
```
