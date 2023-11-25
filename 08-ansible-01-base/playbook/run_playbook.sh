#!/bin/bash

# Запуск Docker контейнеров
docker run -d --name my-fedora-container my-fedora
docker run -d --name my-debian-container my-debian
docker run -d --name my-centos-container my-centos

# Проверка статуса контейнеров
sleep 5

# Запуск Ansible Playbook
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

# Остановка и удаление контейнеров
docker stop my-fedora-container
docker rm my-fedora-container

docker stop my-debian-container
docker rm my-debian-container

docker stop my-centos-container
docker rm my-centos-container

#my-fedora    latest    e5ba765249e9   10 minutes ago      885MB
#my-debian    latest    b6e6469779de   About an hour ago   210MB
#my-centos    latest    c2b1f0af3433   About an hour ago   371MB

