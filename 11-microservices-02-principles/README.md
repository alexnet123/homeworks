# Домашнее задание к занятию «Микросервисы: принципы» Вахрамеев А.В.

### Задача 1: API Gateway

#### Критерии для API Gateway:
- Маршрутизация запросов.
- Проверка аутентификации.
- Терминация HTTPS.

#### Наиболее известные решения для API Gateway:
- Kong
- Apigee
- Nginx

| Критерий / Решение          | Kong | Apigee | Nginx            |
|----------------------------|------|--------|------------------|
| Маршрутизация запросов      | ✔️    | ✔️      | ✔️                |
| Проверка аутентификации     | ✔️    | ✔️      | ✔️ (с модулями)  |
| Терминация HTTPS            | ✔️    | ✔️      | ✔️                |
| Расширяемость (плагины)     | ✔️    | ✔️      | ✔️                |
| Поддержка масштабирования   | Высокая | Высокая | Высокая          |
| Интеграция с облачными сервисами | Ограничено | Ограничено | Ограничено |

Kong - отличный выбор за его гибкость и расширяемость. Apigee подходит для комплексных интеграций и предоставления API. Nginx, будучи мощным и гибким веб-сервером, также может быть настроен как эффективный API Gateway.

### Задача 2: Брокер сообщений

#### Критерии для брокеров сообщений:
- Кластеризация.
- Хранение сообщений на диске.
- Высокая скорость работы.
- Поддержка форматов сообщений.
- Разделение прав доступа.
- Простота эксплуатации.

#### Наиболее известные брокеры сообщений:
- RabbitMQ
- Apache Kafka
- ActiveMQ

| Критерий / Решение          | RabbitMQ | Apache Kafka | ActiveMQ |
|-----------------------------|----------|--------------|----------|
| Кластеризация               | ✔️        | ✔️            | ✔️        |
| Хранение на диске           | ✔️        | ✔️            | ✔️        |
| Высокая скорость            | Средняя   | Высокая      | Средняя   |
| Поддержка форматов          | Ограничено | Отличная     | Хорошая   |
| Разделение прав             | ✔️        | ✔️            | ✔️        |
| Простота эксплуатации       | Высокая   | Средняя      | Высокая   |

Apache Kafka. Kafka идеально подходит для систем с большим объемом данных и высокой пропускной способностью. Он обеспечивает отличную поддержку различных форматов сообщений и хорошо масштабируется. RabbitMQ подойдет для более простых сценариев с меньшим объемом данных.
