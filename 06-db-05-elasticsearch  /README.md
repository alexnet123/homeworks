# Домашнее задание к занятию 5. «Elasticsearch» Вахрамеев А.В.

## Задача 1

`Сборка и публикация образа`

```
root@debian:/home/alex/test/cs/elastic# docker build -t net-elastic .
[+] Building 1.6s (12/12) FINISHED                                                                                           docker:default
 => [internal] load build definition from Dockerfile                                                                                   0.0s
 => => transferring dockerfile: 1.82kB                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/centos:7                                                                            1.3s
 => [auth] library/centos:pull token for registry-1.docker.io                                                                          0.0s
 => [internal] load .dockerignore                                                                                                      0.0s
 => => transferring context: 2B                                                                                                        0.0s
 => [1/7] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4                      0.0s
 => CACHED [2/7] RUN yum install -y wget perl-Digest-SHA &&     yum clean all                                                          0.0s
 => CACHED [3/7] RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.0-linux-x86_64.tar.gz &&     wget h  0.0s
 => CACHED [4/7] RUN groupadd elasticsearch &&     useradd -g elasticsearch elasticsearch                                              0.0s
 => CACHED [5/7] RUN mkdir /var/lib/logs /var/lib/data /elasticsearch/snapshots &&     chown -R elasticsearch:elasticsearch /elastics  0.0s
 => CACHED [6/7] RUN echo "path.logs: /var/lib/logs" >> /elasticsearch/config/elasticsearch.yml &&     echo "path.data: /var/lib/data  0.0s
 => [7/7] RUN echo "discovery.type: single-node" >> /elasticsearch/config/elasticsearch.yml                                            0.3s
 => exporting to image                                                                                                                 0.0s
 => => exporting layers                                                                                                                0.0s
 => => writing image sha256:40cac26d022792ed4ef33d4971f93d319ded0d3c3d536c047f5a56d4e450d3df                                           0.0s
 => => naming to docker.io/library/net-elastic                                                                                         0.0s
root@debian:/home/alex/test/cs/elastic# docker tag net-elastic waxboy/net-elastic:3
root@debian:/home/alex/test/cs/elastic# docker push waxboy/net-elastic:3
The push refers to repository [docker.io/waxboy/net-elastic]
cc12a2bccdc4: Pushed 
9c7072e163d2: Layer already exists 
1e26267f0ce6: Layer already exists 
9fb376b968bf: Layer already exists 
298b29a19b8e: Layer already exists 
5925cc2f3776: Layer already exists 
174f56854903: Layer already exists 
3: digest: sha256:97d287c10484d9be1471d0221898a43e97fc8850b0f3625d0ac65435b88da9ef size: 1791

```
`Увеличение vm.max_map_count`

```
sudo sysctl -w vm.max_map_count=262144

```
`Запуск контейнера`

```

root@netology-elastic:/home/admin# docker run -d -p 9200:9200 waxboy/net-elastic:3
Unable to find image 'waxboy/net-elastic:3' locally
3: Pulling from waxboy/net-elastic
2d473b07cdd5: Already exists 
3350e1fd1c09: Already exists 
cb78c780f646: Already exists 
c3147aca435e: Already exists 
085ad4cbc5f8: Already exists 
e85f71042111: Already exists 
222b7843591a: Pull complete 
Digest: sha256:97d287c10484d9be1471d0221898a43e97fc8850b0f3625d0ac65435b88da9ef
Status: Downloaded newer image for waxboy/net-elastic:3
08d8d31a294e9b37192bbcaa1495d4be02b1a588214f325bc42df17f34d19b09


```
`Запрос к Elasticsearch`

```
root@netology-elastic:/home/admin# docker ps -a
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                    NAMES
08d8d31a294e   waxboy/net-elastic:3   "/elasticsearch/bin/…"   52 seconds ago   Up 51 seconds   0.0.0.0:9200->9200/tcp   lucid_ramanujan
root@netology-elastic:/home/admin# curl localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "usg-RJQtT8iCTfKbKsgMZA",
  "version" : {
    "number" : "7.10.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "51e9d6f22758d0374a0f3f5c6e8f3a7997850f96",
    "build_date" : "2020-11-09T21:30:33.964949Z",
    "build_snapshot" : false,
    "lucene_version" : "8.7.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
root@netology-elastic:/home/admin# 

```

## Задача 2

`Создание индексов`

```
curl -X PUT "localhost:9200/ind-1" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  }
}'

curl -X PUT "localhost:9200/ind-2" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 2,
      "number_of_replicas": 1
    }
  }
}'

curl -X PUT "localhost:9200/ind-3" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 4,
      "number_of_replicas": 2
    }
  }
}'

```
`Получение списка индексов`

```

root@netology-elastic:/home/admin# curl "localhost:9200/_cat/indices?v"
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 3AriOtM3QeOtSOA8YfuQwQ   1   0          0            0       208b           208b
yellow open   ind-3 KuAFb2KzS0uF8dwJOFbisQ   4   2          0            0       832b           832b
yellow open   ind-2 x85zMBBKT_ukgTZ_G04LUw   2   1          0            0       416b           416b

```

`Получение состояния кластера`

```
root@netology-elastic:/home/admin# curl "localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}

```

`Удаление всех индексов`

```
root@netology-elastic:/home/admin# curl -X DELETE "localhost:9200/_all"
{"acknowledged":true}
root@netology-elastic:/home/admin# 
root@netology-elastic:/home/admin# curl "localhost:9200/_cat/indices?v"
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
root@netology-elastic:/home/admin# 

```

## Задача 3

`Создание директории для snapshot`

```
root@netology-elastic:/home/admin# docker run -d -p 9200:9200 -v snapshots:/elasticsearch/snapshots waxboy/net-elastic:3
30ede2055238bdbba0fa566ebd1fba01cb11c600c9e5aae27b61bc20c1ac1f26

root@netology-elastic:/home/admin# docker ps -a
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                    NAMES
30ede2055238   waxboy/net-elastic:3   "/elasticsearch/bin/…"   35 seconds ago   Up 34 seconds   0.0.0.0:9200->9200/tcp   stupefied_noether
root@netology-elastic:/home/admin# 

```
`Регистрация snapshot repository`

```

root@netology-elastic:/home/admin# curl -X PUT "localhost:9200/_snapshot/netology_backup" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/elasticsearch/snapshots"
  }
}'
{"acknowledged":true}
root@netology-elastic:/home/admin# 
root@netology-elastic:/home/admin# 

```
`Создание индекса и выполнение снимка состояния`

```
root@netology-elastic:/home/admin# curl -X PUT "localhost:9200/test" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_replicas": 0,
    "number_of_shards": 1
  }
}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}root@netology-elastic:/home/admin# 

```
`Cнимок состояния кластера:`

```
root@netology-elastic:/home/admin# curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_1?wait_for_completion=true"
{"snapshot":{"snapshot":"snapshot_1","uuid":"TUGxou_TRZWRxrWIlRYxBQ","version_id":7100099,"version":"7.10.0","indices":["test"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2024-02-25T11:21:30.007Z","start_time_in_millis":1708860090007,"end_time":"2024-02-25T11:21:30.207Z","end_time_in_millis":1708860090207,"duration_in_millis":200,"failures":[],"shards":{"total":1,"failed":0,"successful":1}}}root@netology-elastic:/home/admin# 
```

`Удаляем индекс test`

```
root@netology-elastic:/home/admin# curl -X DELETE "localhost:9200/test"
{"acknowledged":true}
root@netology-elastic:/home/admin# 

```
`Создание нового индекс test-2`

```
root@netology-elastic:/home/admin# curl -X PUT "localhost:9200/test-2" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_replicas": 0,
    "number_of_shards": 1
  }
}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}
root@netology-elastic:/home/admin# 

```
`Восстановление состояния из snapshot`

```
root@netology-elastic:/home/admin# curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore"
{"accepted":true}
root@netology-elastic:/home/admin# 

root@netology-elastic:/home/admin# curl -X GET "localhost:9200/test/_search?pretty"
{
  "took" : 36,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 0,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  }
}
root@netology-elastic:/home/admin# curl -X GET "localhost:9200/_cat/indices?v"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 w9xHYI4MTx29EV3iQpSq-Q   1   0          0            0       208b           208b
green  open   test   gMpFqhKcT4mqQ3Q89S8tRg   1   0          0            0       208b           208b

```
