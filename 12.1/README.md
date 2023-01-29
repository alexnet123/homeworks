
# Домашнее задание к занятию "`Базы данных`"      -    `Вахрамеев А.В.`

---
### Легенда

Заказчик передал вам [файл в формате Excel](https://github.com/netology-code/sdb-homeworks/blob/main/resources/hw-12-1.xlsx), в котором сформирован отчёт. 

На основе этого отчёта нужно выполнить следующие задания.

### Задание 1

Опишите не менее семи таблиц, из которых состоит база данных:

- какие данные хранятся в этих таблицах;
- какой тип данных у столбцов в этих таблицах, если данные хранятся в PostgreSQL.

Приведите решение к следующему виду:

Сотрудники (

- идентификатор, первичный ключ, serial,
- фамилия varchar(50),
- ...
- идентификатор структурного подразделения, внешний ключ, integer).

`Ответ`

![Снимок экрана от 2023-01-30 00-45-44](https://user-images.githubusercontent.com/75438030/215357372-a49a07a2-c888-400a-8d3f-236f2a1e7fdd.png)

```
CREATE TABLE 'Сотрудника' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'ФИО' TEXT(100) DEFAULT NULL,
'Оклад' INTEGER DEFAULT NULL,
'Дата найма' NONE DEFAULT NULL,
'Проект на который назначен' INTEGER DEFAULT NULL REFERENCES 'Проект' ('id'),
'Должность' INTEGER DEFAULT NULL REFERENCES 'Должность' ('id'),
'Тип подразделения' INTEGER DEFAULT NULL REFERENCES 'Тип подразделения' ('id'),
'Структурное подразделение' INTEGER DEFAULT NULL REFERENCES 'Структурное подразделение' ('id'),
'Адрес филиала' INTEGER DEFAULT NULL REFERENCES 'Адрес филиала' ('id')
);

CREATE TABLE 'Должность' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'Должность' TEXT(100) DEFAULT NULL
);

CREATE TABLE 'Тип подразделения' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'Тип подразделения' TEXT DEFAULT NULL
);

CREATE TABLE 'Структурное подразделение' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'Структурное подразделение' TEXT DEFAULT NULL
);

CREATE TABLE 'Адрес филиала' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'Адрес филиала' TEXT DEFAULT NULL
);

CREATE TABLE 'Проект' (
'id' INTEGER DEFAULT NULL PRIMARY KEY AUTOINCREMENT,
'Проект' TEXT DEFAULT NULL
);

```

