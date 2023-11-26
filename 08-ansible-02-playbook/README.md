# Домашнее задание к занятию 2 «Работа с Playbook» Вахрамеев А.В.

# Ansible Playbook для установки Clickhouse и Vector

## Описание
Этот Ansible Playbook предназначен для автоматизации установки и настройки Clickhouse и Vector на сервера. Он разделен на две части: первая часть отвечает за установку и настройку Clickhouse, вторая - за установку и настройку Vector.

### Clickhouse
- Установка Clickhouse выполняется на группе хостов `clickhouse`.
- Сценарий включает в себя загрузку пакетов Clickhouse, установку этих пакетов и создание базы данных `logs`.

### Vector
- Установка Vector производится на группе хостов `vector`.
- Сценарий включает в себя загрузку и установку .deb пакета Vector, создание директории для Vector, развертывание конфигурации Vector и запуск сервиса Vector.

## Параметры
- `clickhouse_version`: версия Clickhouse для установки.
- `clickhouse_packages`: пакеты Clickhouse для установки.

## Требования
- Доступ к управляемым хостам через SSH.
- Наличие прав суперпользователя на целевых хостах.

## Примеры использования
Для запуска Playbook используйте команды:

```
git clone https://github.com/alexnet123/homeworks.git
cd homeworks/08-ansible-02-playbook/playbook/
ansible-playbook -i inventory/prod.yml site.yml
```
