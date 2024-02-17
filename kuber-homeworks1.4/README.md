# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1» Вахрамеев А.В.


### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-multitool-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-multitool
  template:
    metadata:
      labels:
        app: nginx-multitool
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
      - name: multitool
        image: praqma/network-multitool
        ports:
        - containerPort: 1180
        env:
        - name: HTTP_PORT
          value: "1180"
        - name: HTTPS_PORT
          value: "11443"

```

2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.

```

apiVersion: v1
kind: Service
metadata:
  name: nginx-multitool-service
spec:
  type: NodePort
  ports:
    - name: nginx-port
      port: 9001
      targetPort: 80
      nodePort: 30080
    - name: multitool-port
      port: 9002
      targetPort: 1180
      nodePort: 30180
  selector:
    app: nginx-multitool


```

3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.

```
apiVersion: v1
kind: Pod
metadata:
  name: multitool-pod
spec:
  containers:
  - name: multitool
    image: praqma/network-multitool


```
```
root@master0-ru-central1-a:/home/admin# kubectl get pod
NAME                                         READY   STATUS    RESTARTS   AGE
multitool-pod                                1/1     Running   0          96s
nginx-multitool-deployment-88cf96565-8fqh9   2/2     Running   0          13m
nginx-multitool-deployment-88cf96565-bk55p   2/2     Running   0          13m
nginx-multitool-deployment-88cf96565-d9htb   2/2     Running   0          12m
root@master0-ru-central1-a:/home/admin# kubectl get svc
NAME                      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
kubernetes                ClusterIP   10.96.0.1      <none>        443/TCP                         6h31m
my-nginx-service          ClusterIP   10.108.40.91   <none>        80/TCP                          167m
nginx-multitool-service   NodePort    10.108.0.60    <none>        9001:30080/TCP,9002:30180/TCP   170m
root@master0-ru-central1-a:/home/admin# 

```

4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.


5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.
2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.
