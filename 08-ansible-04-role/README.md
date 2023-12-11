# Домашнее задание к занятию 4 «Работа с roles» Вахрамеев А.В.

## Запуск  

Развернем в Yandex Cloud три виртуальных машины: для `clickhouse`, для `vector` и для `lighthouse`.

```
git clone https://github.com/alexnet123/homeworks.git
cd homeworks/08-ansible-04-role/terraform
terraform apply
```
Terraform создаст в корне проекта динамеческий фаил hosts

Переходим в каталог playbook и запускаем установку ролей.

```
cd homeworks/08-ansible-04-role/ansible
root@debian:/home/alex/test/homeworks/08-ansible-04-role/ansible# ansible-galaxy install -r requirements.yml
Starting galaxy role install process
- extracting clickhouse to /root/.ansible/roles/clickhouse
- clickhouse (1.13) was installed successfully
- extracting vector to /root/.ansible/roles/vector
- vector was installed successfully
- extracting lighthouse to /root/.ansible/roles/lighthouse
- lighthouse was installed successfully
root@debian:/home/alex/test/homeworks/08-ansible-04-role/ansible# ansible-galaxy list
# /root/.ansible/roles
- vector, (unknown version)
- clickhouse, 1.13
- lighthouse, (unknown version)

```
Развернем роли на виртуальные машины в Yandex Cloud

```
ansible-playbook -i ../hosts start_role.yml
```

Данный проект использует три публичных репозитория

```
https://github.com/alexnet123/lighthouse-role
```

```
https://github.com/alexnet123/vector-role
```

```
https://github.com/AlexeySetevoi/ansible-clickhouse
```