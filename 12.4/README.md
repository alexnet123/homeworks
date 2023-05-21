# Домашнее задание к занятию "`12.4. «SQL. Часть 2»`" - `Вахрамеев А.В.`

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

`Ответ:`

```
SELECT  staff.first_name, staff.last_name, city.city, COUNT(customer.customer_id) AS user_count
FROM store 
INNER JOIN staff ON store.manager_staff_id  = staff.staff_id
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN customer ON store.store_id = customer.store_id
INNER JOIN city ON address.city_id = city.city_id 
GROUP BY store.store_id
HAVING user_count > 300;

```
![Снимок экрана от 2023-02-07 21-33-25](https://user-images.githubusercontent.com/75438030/217334719-df47bdbb-8f01-433d-b335-50a53c473a53.png)

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

`Ответ:`

```
SELECT COUNT(*)  FROM film WHERE `length` > (SELECT  AVG(`length`) FROM film);

```

![Снимок экрана от 2023-02-07 15-54-55](https://user-images.githubusercontent.com/75438030/217250584-84ce73e0-b943-4d69-bf10-0ac05566101d.png)


### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

`Ответ:`

```
SELECT YEAR(payment_date), MONTH(payment_date), SUM(amount) AS full_summ, 
COUNT(rental_id) FROM payment GROUP BY YEAR(payment_date), 
MONTH(payment_date) ORDER BY full_summ DESC;

```

![Снимок экрана от 2023-02-07 18-00-12](https://user-images.githubusercontent.com/75438030/217280970-d84f6676-1524-46d8-8f58-af8b4d14f715.png)


## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

`Ответ:`

```
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(payment.payment_id) AS sales,
	CASE
		WHEN COUNT(payment.payment_id) > 8000 THEN 'YES'
		WHEN COUNT(payment.payment_id) < 8000 THEN 'NO'
	END AS premium
FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id;

```

![Снимок экрана от 2023-02-07 22-40-33](https://user-images.githubusercontent.com/75438030/217348333-39e2df58-57a7-4241-ab62-28dfa2fcd0fa.png)


### Задание 5*

Найдите фильмы, которые ни разу не брали в аренду.
