# Домашнее задание к занятию 4 «Работа с roles» Вахрамеев А.В.

## Запуск  
### Развернем в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

```
git clone https://github.com/alexnet123/homeworks.git
cd homeworks/08-ansible-04-role/terraform
terraform apply
```
### Terraform создаст в корне проекта динамеческий фаил hosts, переходим в каталог playbook и запускаем start_role.yml

```
cd homeworks/08-ansible-04-role/ansible
ansible-playbook -i ../hosts start_role.yml
```
### После запуска terraform и ansible в Yandex Cloud запустятся три машины после чего на них установится ПО.
