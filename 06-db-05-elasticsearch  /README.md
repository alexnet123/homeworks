# Домашнее задание к занятию 5. «Elasticsearch» Вахрамеев А.В.

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
`Выполните запрос к Elasticsearch`

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
