# Домашнее задание к занятию Troubleshooting Вахрамеев А.В.

### Цель задания

Устранить неисправности при деплое приложения.

### Чеклист готовности к домашнему заданию

1. Кластер K8s.

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
```
root@master0-ru-central1-a:/home/admin# k get nodes 
NAME                    STATUS   ROLES           AGE     VERSION
master0-ru-central1-a   Ready    control-plane   2m33s   v1.28.8
worker0-ru-central1-a   Ready    <none>          2m19s   v1.28.8
worker1-ru-central1-a   Ready    <none>          2m19s   v1.28.8
root@master0-ru-central1-a:/home/admin# wget https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
--2024-03-26 07:41:58--  https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.111.133, 185.199.110.133, 185.199.109.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.111.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 937 [text/plain]
Saving to: ‘task.yaml’

task.yaml                                            100%[=====================================================================================================================>]     937  --.-KB/s    in 0s      

2024-03-26 07:41:58 (55.4 MB/s) - ‘task.yaml’ saved [937/937]

root@master0-ru-central1-a:/home/admin# k apply -f task.yaml 
Error from server (NotFound): error when creating "task.yaml": namespaces "web" not found
Error from server (NotFound): error when creating "task.yaml": namespaces "data" not found
Error from server (NotFound): error when creating "task.yaml": namespaces "data" not found

```

2. Выявить проблему и описать.

`Создаем два namespace (web, data) и устанавливаем приложение`

```

root@master0-ru-central1-a:/home/admin# k create namespace web
namespace/web created
root@master0-ru-central1-a:/home/admin# k create namespace data
namespace/data created
root@master0-ru-central1-a:/home/admin# k apply -f task.yaml 
deployment.apps/web-consumer created
deployment.apps/auth-db created
service/auth-db created
root@master0-ru-central1-a:/home/admin# 


```
`Видим что не резолвится auth-db`

```

root@master0-ru-central1-a:/home/admin# k logs web-consumer-5f87765478-8q6hc -n web
curl: (6) Couldn't resolve host 'auth-db'
curl: (6) Couldn't resolve host 'auth-db'
curl: (6) Couldn't resolve host 'auth-db'
curl: (6) Couldn't resolve host 'auth-db'
curl: (6) Couldn't resolve host 'auth-db'

```

3. Исправить проблему, описать, что сделано.

`Исправим деплоймент и запустим, укажем имя auth-db в другом namespace`

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-consumer
  namespace: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-consumer
  template:
    metadata:
      labels:
        app: web-consumer
    spec:
      containers:
      - command:
        - sh
        - -c
        - while true; do curl auth-db.data; sleep 10; done
        image: radial/busyboxplus:curl
        name: busybox

```

4. Продемонстрировать, что проблема решена.

`После перезапуска приложение web-consumer подключается  к auth-db`

```

root@master0-ru-central1-a:/home/admin# k get pods -n web
NAME                            READY   STATUS    RESTARTS   AGE
web-consumer-7f5f49b674-gj985   1/1     Running   0          50s
web-consumer-7f5f49b674-m56c5   1/1     Running   0          51s
root@master0-ru-central1-a:/home/admin# k logs web-consumer-7f5f49b674-gj985 -n web
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0  45522      0 --:--:-- --:--:-- --:--:--  597k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

```
