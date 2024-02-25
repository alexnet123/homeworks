FROM centos:7

# Установка необходимых инструментов
RUN yum install -y wget perl-Digest-SHA && \
    yum clean all

# Скачивание и установка Elasticsearch
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.0-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-7.10.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.10.0-linux-x86_64.tar.gz && \
    mv elasticsearch-7.10.0 /elasticsearch && \
    rm -f elasticsearch-7.10.0-linux-x86_64.tar.gz && \
    rm -f elasticsearch-7.10.0-linux-x86_64.tar.gz.sha512

# Создание пользователя и группы
RUN groupadd elasticsearch && \
    useradd -g elasticsearch elasticsearch

# Настройка прав доступа
RUN mkdir /var/lib/logs /var/lib/data /elasticsearch/snapshots && \
    chown -R elasticsearch:elasticsearch /elasticsearch /var/lib/logs /var/lib/data /elasticsearch/snapshots

# Конфигурация Elasticsearch
RUN echo "path.logs: /var/lib/logs" >> /elasticsearch/config/elasticsearch.yml && \
    echo "path.data: /var/lib/data" >> /elasticsearch/config/elasticsearch.yml && \
    echo "path.repo: [\"/elasticsearch/snapshots\"]" >> /elasticsearch/config/elasticsearch.yml && \
    echo "node.name: netology_test" >> /elasticsearch/config/elasticsearch.yml && \
    echo "network.host: 0.0.0.0" >> /elasticsearch/config/elasticsearch.yml

RUN echo "discovery.type: single-node" >> /elasticsearch/config/elasticsearch.yml

USER elasticsearch

# Открытие порта 9200
EXPOSE 9200

# Запуск Elasticsearch
CMD ["/elasticsearch/bin/elasticsearch"]
