# Домашнее задание к занятию 11.3. «ELK»  - `Вахрамеев А.В.`

---

### Задание 1. Elasticsearch 

Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный. 

*Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name*.

`Ответ`

![Снимок экрана от 2023-01-22 21-36-50](https://user-images.githubusercontent.com/75438030/213933648-686efaec-49a3-4496-8369-1e1bf00d9721.png)

---

### Задание 2. Kibana

Установите и запустите Kibana.

*Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty*.

`Ответ`

![Снимок экрана от 2023-01-22 21-39-21](https://user-images.githubusercontent.com/75438030/213933769-38ee0bd1-fab2-4b6f-a4db-0b89352b0a58.png)

---

### Задание 3. Logstash

Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.*

`Ответ`

![Снимок экрана от 2023-01-22 21-43-10](https://user-images.githubusercontent.com/75438030/213933896-32f2309b-d9d0-45c5-bc7e-d2183aef833a.png)


![Снимок экрана от 2023-01-22 21-44-11](https://user-images.githubusercontent.com/75438030/213933935-c193c144-75c4-487e-b89a-9ddf3c1a567c.png)

---

### Задание 4. Filebeat. 

Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.*

`Ответ`

![Снимок экрана от 2023-01-22 21-11-33](https://user-images.githubusercontent.com/75438030/213933544-0abf6c68-dc49-48bc-a779-7d951601f366.png)


![Снимок экрана от 2023-01-22 21-44-47](https://user-images.githubusercontent.com/75438030/213933952-e73afb97-3dd2-4265-a746-e8c54a4effa8.png)


## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 5*. Доставка данных 

Настройте поставку лога в Elasticsearch через Logstash и Filebeat любого другого сервиса , но не Nginx. 
Для этого лог должен писаться на файловую систему, Logstash должен корректно его распарсить и разложить на поля. 

*Приведите скриншот интерфейса Kibana, на котором будет виден этот лог и напишите лог какого приложения отправляется.*
