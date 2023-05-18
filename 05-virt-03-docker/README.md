# Домашнее задание к занятию 3. «Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера»  Вахрамеев А.В

# Задача 1

```
https://hub.docker.com/layers/waxboy/main-nginx/1/images/sha256-49238a6f23f30b0e9d6cddd2063432ae682e644bb347075971bf39008dc83a45?context=explore
```

# Задача 2

Высоконагруженное монолитное Java веб-приложение:

Можно рассмотреть использование Docker-контейнеров для упаковки и запуска Java-приложения, что позволит легко масштабировать и развертывать его на разных средах.

Node.js веб-приложение:

Здесь также можно воспользоваться Docker-контейнерами, так как они обеспечат легкое развертывание и масштабирование приложения.

Мобильное приложение с версиями для Android и iOS:

Для разработки и тестирования мобильных приложений вполне подойдут эмуляторы или симуляторы операционных систем внутри виртуальных машин.

Шина данных на базе Apache Kafka:

Можно рассмотреть все варианты - ( Docker-контейнеров, виртуальная машина, физическая машина )

Elasticsearch-кластер, Logstash и Kibana:

Elasticsearch может использовать Docker-контейнеры для удобного развертывания и масштабирования.


# Задача 3
```

root@docker:/home/admin/05-virt-03-docker/task3# docker run -it -d -v $(pwd)/data:/data --name debian-container debian:9
c454c211a15bf9b0b6c1ef86f7dd8be77abb0df9cb5d8497abb2d6e2a24adbe8

root@docker:/home/admin/05-virt-03-docker/task3# docker ps
CONTAINER ID   IMAGE      COMMAND   CREATED         STATUS         PORTS     NAMES
c454c211a15b   debian:9   "bash"    5 seconds ago   Up 4 seconds             debian-container

root@docker:/home/admin/05-virt-03-docker/task3# docker run -it -d -v $(pwd)/data:/data --name centos-container centos:7
2ff3b19a60be1685ee6395257fecb451eb9216d0d84b76838bc7355b8c5f572d

root@docker:/home/admin/05-virt-03-docker/task3# docker ps
CONTAINER ID   IMAGE      COMMAND       CREATED          STATUS          PORTS     NAMES
2ff3b19a60be   centos:7   "/bin/bash"   3 seconds ago    Up 2 seconds              centos-container
c454c211a15b   debian:9   "bash"        30 seconds ago   Up 29 seconds             debian-container

root@docker:/home/admin/05-virt-03-docker/task3# docker exec -it 2ff3b19a60be /bin/bash

[root@2ff3b19a60be /]# ls
anaconda-post.log  bin  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

[root@2ff3b19a60be /]# ls data/

[root@2ff3b19a60be /]# echo 'test' > data/test

[root@2ff3b19a60be /]# ls data/
test

[root@2ff3b19a60be /]# exit
exit

root@docker:/home/admin/05-virt-03-docker/task3# docker ps
CONTAINER ID   IMAGE      COMMAND       CREATED              STATUS              PORTS     NAMES
2ff3b19a60be   centos:7   "/bin/bash"   About a minute ago   Up About a minute             centos-container
c454c211a15b   debian:9   "bash"        2 minutes ago        Up 2 minutes                  debian-container

root@docker:/home/admin/05-virt-03-docker/task3# ls data/
test

root@docker:/home/admin/05-virt-03-docker/task3# cat data/test 
test

root@docker:/home/admin/05-virt-03-docker/task3# docker exec -it c454c211a15b /bin/bash

root@c454c211a15b:/# cat data/test 
test

root@c454c211a15b:/# 
```
# Задача 4

```
https://hub.docker.com/layers/waxboy/ansible/1/images/sha256-8f689c1bf6145e8fbd2427f9e7a5c79eb8e803e8c968f72adff574ae69c53610?context=repo
```
