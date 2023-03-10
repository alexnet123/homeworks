# Домашнее задание к занятию "12.3 `«SQL. Часть 1»`" - `Вахрамеев А.В.`


---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

`Ответ:`

```
SELECT  district FROM address WHERE district LIKE 'K%a' AND district NOT LIKE '% %';

```

![Снимок экрана от 2023-02-06 00-25-15](https://user-images.githubusercontent.com/75438030/216846916-82afae08-b2c6-4235-875c-e08f6227e050.png)


### Задание 2

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых превышает 10.00.

`Ответ:`

```
SELECT * FROM payment WHERE payment_date BETWEEN '2005-06-15' AND '2005-06-19' AND amount  > 10.00;

```

![Снимок экрана от 2023-02-06 00-42-24](https://user-images.githubusercontent.com/75438030/216847702-ccb1e46c-d7e8-4f0f-b285-bb9dd62b3c54.png)

:triangular_flag_on_post:`Исправил:`

```
SELECT * FROM payment WHERE payment_date BETWEEN '2005-06-15 00:00:00' AND '2005-06-18 23:59:59' AND amount  > 10.00;

```

![Снимок экрана от 2023-02-07 23-14-51](https://user-images.githubusercontent.com/75438030/217355107-ac56a1c5-531f-41be-8737-4dc4f5678ddb.png)


### Задание 3

Получите последние пять аренд фильмов.

`Ответ:`

```
SELECT * FROM rental ORDER BY rental_date  DESC LIMIT 5;

```

![Снимок экрана от 2023-02-07 14-20-35](https://user-images.githubusercontent.com/75438030/217231375-31dfb906-3236-48dc-bb1f-7d448df76779.png)


### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'.

`Ответ:`

```
SELECT customer_id ,store_id,REPLACE(LCASE(first_name),'ll', 'pp'),LCASE(last_name),email,address_id, active,create_date,last_update 
FROM customer WHERE first_name = 'Kelly' OR first_name = 'Willie';

```

![Снимок экрана от 2023-02-07 14-10-17](https://user-images.githubusercontent.com/75438030/217229172-b7465217-2d3b-42c1-9bab-98a95ec713ed.png)


## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 5*

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

`Ответ:`

```

SELECT REGEXP_REPLACE(email,'@(.*)',''), REGEXP_REPLACE(email,'(.*)@',''),email  FROM customer;

```

![Снимок экрана от 2023-02-07 14-33-01](https://user-images.githubusercontent.com/75438030/217233921-21373837-2f02-46e6-842a-d56340bc7cf1.png)


### Задание 6*

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.

`Ответ:`

```
SELECT 
CONCAT(UPPER( LEFT (LCASE(REGEXP_REPLACE(email,'@(.*)','')),1)), SUBSTRING(LCASE(REGEXP_REPLACE(email,'@(.*)','')),2)), 
CONCAT(UPPER( LEFT (REGEXP_REPLACE(email,'(.*)@',''),1)),  
SUBSTRING(REGEXP_REPLACE(email,'(.*)@',''),2)  ),email  FROM customer;

```

![Снимок экрана от 2023-02-07 15-07-29](https://user-images.githubusercontent.com/75438030/217240838-e271fcd2-abb3-45ff-bdd9-85a29d3d10a4.png)

---
