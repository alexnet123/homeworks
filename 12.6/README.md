# Домашнее задание к занятию "`12.6. «Репликация и масштабирование. Часть 1»`" - `Вахрамеев А.В.`

---

### Задание 1

На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

*Ответить в свободной форме.*

`Ответ:`

Режим репликации Master-Slave в MySQL позволяет повысить производительность и масштабируемость базы данных, а также обеспечить безопасность и надежность. В этом режиме используются два сервера: главный (master) и зеркальный сервер (slave). Преимущества такого режима включают в себя:

Повышение доступность данных — даже если с master-сервером что-либо произойдет, будет доступна актуальная копия данных, без каких-либо потерь.

Мы сможем не нагружать master-сервер «тяжелыми» операциями — например, со slave можно делать резервные дампы таблиц без снижения производительности основного сервера.

С помощью дополнительных инструментов (mysql-proxy, например) можно использовать slave-серверы для чтения данных, а запись делать на master. Другими словами, можно легко создать мощный масштабируемый и распределенный кластер

---

### Задание 2

Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

*Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.*

`Ответ:`

```
root@mysql:~# docker ps
CONTAINER ID   IMAGE       COMMAND                  CREATED       STATUS       PORTS                 NAMES
0ea1392e0629   mysql:8.0   "docker-entrypoint.s…"   3 hours ago   Up 3 hours   3306/tcp, 33060/tcp   mysql-slave
32519228192c   mysql:8.0   "docker-entrypoint.s…"   3 hours ago   Up 3 hours   3306/tcp, 33060/tcp   mysql-master
```
`Смотрис ip контейнера`
```
root@mysql:~# docker container inspect -f '{{ .NetworkSettings.Networks.replication.IPAddress }}' mysql-master
172.19.0.2

root@mysql:~# docker container inspect -f '{{ .NetworkSettings.Networks.replication.IPAddress }}' mysql-slave
172.19.0.3
```
`Делаем тестовый SQL запрос на master`
```
root@mysql:~# mysql -u root -p"qwertyX14" -h 172.19.0.2 -e "USE sakila; SELECT * FROM actor ORDER BY actor_id DESC LIMIT 5;"
```
![Снимок экрана от 2023-02-15 20-41-36](https://user-images.githubusercontent.com/75438030/219109806-d0ad2a4d-5d89-401c-a262-a3c72fd60e7c.png)

`Делаем тестовый SQL запрос на slave`
```
root@mysql:~# mysql -u root -p"qwertyX14" -h 172.19.0.3 -e "USE sakila; SELECT * FROM actor ORDER BY actor_id DESC LIMIT 5;"
```
![Снимок экрана от 2023-02-15 20-41-58](https://user-images.githubusercontent.com/75438030/219109880-f8506c83-3e29-4ea2-a3c3-232576171381.png)

`Добавим запись в БД master`
```
mysql -u root -p"qwertyX14" -h 172.19.0.2 -e "USE sakila; INSERT INTO actor (first_name, last_name) VALUES ('ALEX', 'VAKHRAMEEV');"

```
`Проверка синхронизации master-slave`

![Снимок экрана от 2023-02-15 20-45-11](https://user-images.githubusercontent.com/75438030/219110609-a9a2f758-0c91-4721-86a0-ecf2ef5a911c.png)

`mysql -u root -p"qwertyX14" -h 172.19.0.3 -e "SHOW SLAVE STATUS\G"`
![Снимок экрана от 2023-02-15 20-47-00](https://user-images.githubusercontent.com/75438030/219111128-fdffffbb-547a-47e0-83d0-765130dcedec.png)


---
