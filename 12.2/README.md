# Домашнее задание к занятию "`12.2. «Работа с данными (DDL/DML)»`" - `Вахрамеев А.В.`


Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

`Ответ:`

![Снимок экрана от 2023-01-30 21-12-23](https://user-images.githubusercontent.com/75438030/215560690-d08b1839-9705-4131-9c15-42bf7649fd0f.png)


1.2. Создайте учётную запись sys_temp. 

`Ответ:`

```
CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'password123';

```

1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)

`Ответ:`

```
SELECT user FROM mysql.user;

```

![Снимок экрана от 2023-01-30 21-25-40](https://user-images.githubusercontent.com/75438030/215563306-9bf861c0-86a8-4e8c-b847-3f604d3b513a.png)


1.4. Дайте все права для пользователя sys_temp. 

`Ответ:`

```
GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'localhost';

```

1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

`Ответ:`

![Снимок экрана от 2023-01-30 21-33-46](https://user-images.githubusercontent.com/75438030/215564850-9f0b1eeb-4e41-4535-adb1-0420b9876bcf.png)


1.6. Переподключитесь к базе данных от имени sys_temp.

`Ответ:`

![Снимок экрана от 2023-01-30 21-37-13](https://user-images.githubusercontent.com/75438030/215565513-6cceb76d-22ee-444f-bb95-2cb90e74ce01.png)


Для смены типа аутентификации с sha2 используйте запрос: 
```sql
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

`Ответ:`

![Снимок экрана от 2023-01-30 21-59-02](https://user-images.githubusercontent.com/75438030/215569854-f4208942-30d8-498b-9994-55afec8bdf87.png)


1.7. Восстановите дамп в базу данных.

`Ответ:`

```

CREATE DATABASE sakila DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

bash-4.4# mysql -u sys_temp -p sakila < /home/sakila-db/sakila
sakila-data.sql    sakila-schema.sql  sakila.mwb         
bash-4.4# mysql -u sys_temp -p sakila < /home/sakila-db/sakila-schema.sql 
Enter password: 
bash-4.4# mysql -u sys_temp -p sakila < /home/sakila-db/sakila-data.sql   

```

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)

`Ответ:`

```
SHOW DATABASES;
USE sakila;
SHOW TABLES;

```

![Снимок экрана от 2023-01-30 23-00-09](https://user-images.githubusercontent.com/75438030/215582823-e79195d4-7272-4dbc-aaca-5e5d1f372112.png)


---

### Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
```
Название таблицы | Название первичного ключа
customer         | customer_id
```

`Ответ:`

```

| actor                      | actor_id
| actor_info                 | -
| address                    | address_id
| category                   | category_id
| city                       | city_id
| country                    | country_id
| customer                   | customer_id
| customer_list              | -
| film                       | film_id
| film_actor                 | actor_id, film_id
| film_category              | film_id, category_id
| film_list                  | -
| film_text                  | film_id
| inventory                  | inventory_id
| language                   | language_id
| nicer_but_slower_film_list | -
| payment                    | payment_id
| rental                     | rental_id
| sales_by_film_category     | -
| sales_by_store             | -
| staff                      | staff_id
| staff_list                 | -
| store                      | store_id

```

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 3*
3.1. Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

3.2. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*
