# Домашнее задание к занятию 3 «Использование Ansible» Вахрамеев А.В

## Запуск  
### Развернем в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

```
git clone https://github.com/alexnet123/homeworks.git
cd homeworks/08-ansible-03-yandex/terraform
terraform apply
```
### Terraform создаст в корне проекта динамеческий фаил hosts, переходим в каталог playbook и запускаем site.yml

```
cd homeworks/08-ansible-03-yandex/playbook
ansible-playbook -i ../hosts site.yml
```
### После запуска terraform и ansible в Yandex Cloud запустятся три машины после чего на них установится ПО.
