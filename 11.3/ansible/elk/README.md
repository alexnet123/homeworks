# ELK


`Заметка`

```

# Password reset
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

# Elastik test
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic https://localhost:9200
curl -k --user elastic:'ktNBdiTxO3hKqASVvHyu' https://127.0.0.1:9200

# Сгенерируем токен для Kibana
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

# Сгенерируем PINCODE для Kibana
/usr/share/kibana/bin/kibana-verification-code

```
---

![Снимок экрана от 2023-01-21 01-01-19](https://user-images.githubusercontent.com/75438030/213813082-d4c7fd18-a202-4e34-bf68-8b6cd242697c.png)

---
