# Домашнее задание к занятию «Продвинутые методы работы с Terraform» Вахрамеев А.В.


### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля.
2. Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

![Screenshot from 2023-11-19 22-40-43](https://github.com/alexnet123/homeworks/assets/75438030/4c6f00df-8c82-455c-ac37-139149b7b0b6)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
![Screenshot from 2023-11-25 15-58-31](https://github.com/alexnet123/homeworks/assets/75438030/1adccc33-6538-45b7-8881-4f14261393a5)


### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

```
terraform state list
terraform state rm module.vpc_dev
terraform state rm module.vm
```

![Screenshot from 2023-11-25 16-13-12](https://github.com/alexnet123/homeworks/assets/75438030/984ef186-3526-449c-9930-d8a6f1f45ac8)
![Screenshot from 2023-11-25 16-19-38](https://github.com/alexnet123/homeworks/assets/75438030/c4221e2a-adaa-4f65-b0ae-160091de744c)

```
terraform import module.vpc_dev.yandex_vpc_network.vpc_network enpf428k6c94pbbpjl6g
```

![Screenshot from 2023-11-25 16-22-44](https://github.com/alexnet123/homeworks/assets/75438030/72c8895e-16a3-42e0-9888-df6cd8d0ead9)

```
terraform import module.vpc_dev.yandex_vpc_subnet.vpc_subnet e9bt48afnc18pjsiv6pg
```

![Screenshot from 2023-11-25 16-22-59](https://github.com/alexnet123/homeworks/assets/75438030/5bd7f002-0951-438b-89f5-524dda7f0ae4)


## Дополнительные задания (со звёздочкой*)


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  

Обновленный код находится в файлах 
  
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   ter-homeworks-04/src/main.tf
	modified:   ter-homeworks-04/src/vpc/main.tf
	modified:   ter-homeworks-04/src/vpc/outputs.tf
	modified:   ter-homeworks-04/src/vpc/variables.tf

root@debian:/home/alex/test/homeworks# git commit -m 'ter-homeworks-04 Task 4'
[main d235a41] ter-homeworks-04 Task 4
 4 files changed, 128 insertions(+), 31 deletions(-)

```






