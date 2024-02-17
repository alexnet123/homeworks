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
root@master0-ru-central1-a:/home/admin# kubectl get svc
NAME                      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
kubernetes                ClusterIP   10.96.0.1      <none>        443/TCP             6h39m
my-nginx-service          ClusterIP   10.108.40.91   <none>        80/TCP              175m
nginx-multitool-service   ClusterIP   10.108.0.60    <none>        9001/TCP,9002/TCP   178m


```

4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.

`root@master0-ru-central1-a:/home/admin# kubectl exec multitool-pod -- curl nginx-multitool-service:9001`

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 <!DOCTYPE html>0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
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

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
  615  100   615    0     0   370k      0 --:--:-- --:--:-- --:--:--  600k
```

`root@master0-ru-central1-a:/home/admin# kubectl exec multitool-pod -- curl nginx-multitool-service:9002`

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0Praqma Network MultiTool (with NGINX) - nginx-multitool-deployment-88cf96565-8fqh9 - 10.0.0.224 - HTTP: 1180 , HTTPS: 11443
<br>
<hr>
<br>

<h1>05 Jan 2022 - Press-release: `Praqma/Network-Multitool` is now `wbitt/Network-Multitool`</h1>

<h2>Important note about name/org change:</h2>
<p>
Few years ago, I created this tool with Henrik Høegh, as `praqma/network-multitool`. Praqma was bought by another company, and now the "Praqma" brand is being dismantled. This means the network-multitool's git and docker repositories must go. Since, I was the one maintaining the docker image for all these years, it was decided by the current representatives of the company to hand it over to me so I can continue maintaining it. So, apart from a small change in the repository name, nothing has changed.<br>
</p>
<p>
The existing/old/previous container image `praqma/network-multitool` will continue to work and will remain available for **"some time"** - may be for a couple of months - not sure though. 
</p>
<p>
- Kamran Azeem <kamranazeem@gmail.com> <a href=https://github.com/KamranAzeem>https://github.com/KamranAzeem</a>
</p>

<h2>Some important URLs:</h2>

<ul>
  <li>The new official github repository for this tool is: <a href=https://github.com/wbitt/Network-MultiTool>https://github.com/wbitt/Network-MultiTool</a></li>

100  1596  100  1596    0     0   552k      0 --:--:-- --:--:-- --:--:--  779k
ub.docker.com/r/wbitt/network-multitool>https://hub.docker.com/r/wbitt/network-multitool</a></li>
</ul>

<br>
Or:
<br>

<pre>
  <code>
  docker pull wbitt/network-multitool
  </code>
</pre>


<hr>



```


------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.

```
root@master0-ru-central1-a:/home/admin# cat ext_service4_1.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-external-service
spec:
  type: NodePort
  ports:
    - name: nginx-port
      port: 9001
      targetPort: 80
  selector:
    app: nginx-multitool


```

2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.

```
root@master0-ru-central1-a:/home/admin# kubectl exec multitool-pod -- curl nginx-external-service:9001
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
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

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
100   615  100   615    0     0   212k      0 --:--:-- --:--:-- --:--:--  300k

```
```
root@master0-ru-central1-a:/home/admin# kubectl get svc
NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
kubernetes                ClusterIP   10.96.0.1       <none>        443/TCP             6h43m
my-nginx-service          ClusterIP   10.108.40.91    <none>        80/TCP              179m
nginx-external-service    NodePort    10.107.29.198   <none>        9001:31837/TCP      3s
nginx-multitool-service   ClusterIP   10.108.0.60     <none>        9001/TCP,9002/TCP   3h2m
```
![Screenshot from 2024-02-17 18-25-10](https://github.com/alexnet123/homeworks/assets/75438030/184ef5d0-b3e6-43bb-a6cb-1dae3f13c9c0)

