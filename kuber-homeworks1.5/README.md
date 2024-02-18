# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2» Вахрамеев А.В,

### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80

```

2. Создать Deployment приложения _backend_ из образа multitool. 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-deployment
spec:
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: multitool
        image: praqma/network-multitool
        ports:
        - containerPort: 8080
```

3. Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера. 

```
apiVersion: v1
kind: Service
metadata:
  name: backend-service
spec:
  selector:
    app: backend
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 80
```
```
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80

```

4. Продемонстрировать, что приложения видят друг друга с помощью Service.

```
root@master0-ru-central1-a:/home/admin# kubectl get pod

NAME                                   READY   STATUS    RESTARTS   AGE
backend-deployment-55bcdd5766-hl5h6    1/1     Running   0          11m
frontend-deployment-7766f6c5f8-dmltv   1/1     Running   0          11m
frontend-deployment-7766f6c5f8-dwm92   1/1     Running   0          11m
frontend-deployment-7766f6c5f8-rzhqq   1/1     Running   0          11m


root@master0-ru-central1-a:/home/admin# kubectl exec frontend-deployment-7766f6c5f8-dmltv -- curl backend-service:8080

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0Praqma Network MultiTool (with NGINX) - backend-deployment-55bcdd5766-hl5h6 - 10.0.0.190 - HTTP: 80 , HTTPS: 443
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

  <li>The docker repository to pull this image is now: <a href=https://hub.docker.com/r/wbitt/network-multitool>https://hub.docker.com/r/wbitt/network-multitool</a></li>
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

100  1585  100  1585    0     0   286k      0 --:--:-- --:--:-- --:--:--  309k



root@master0-ru-central1-a:/home/admin# kubectl exec backend-deployment-55bcdd5766-hl5h6 -- curl frontend-service


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
100   615  100   615    0     0   253k      0 --:--:-- --:--:-- --:--:--  300k


```
------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller.
2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_.
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.


```
root@master0-ru-central1-a:/home/admin# kubectl get svc
NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
backend-service                      ClusterIP      10.101.234.188   <none>        8080/TCP                     16h
frontend-service                     ClusterIP      10.106.38.95     <none>        80/TCP                       16h
ingress-nginx-controller             LoadBalancer   10.102.46.78     <pending>     80:31915/TCP,443:32615/TCP   59m
ingress-nginx-controller-admission   ClusterIP      10.107.25.112    <none>        443/TCP                      59m
kubernetes                           ClusterIP      10.96.0.1        <none>        443/TCP                      16h
```
```
root@master0-ru-central1-a:/home/admin# kubectl get ingress
NAME              CLASS   HOSTS          ADDRESS   PORTS   AGE
example-ingress   nginx   exec.test.ru             80      15h

```

```
root@master0-ru-central1-a:/home/admin# cat ingress.yaml 
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: exec.test.ru
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend-service
                port:
                  number: 80
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: backend-service
                port:
                  number: 8080

```

![Screenshot from 2024-02-18 15-17-18](https://github.com/alexnet123/homeworks/assets/75438030/2525196a-dfb1-4e9d-b759-09d06701b409)

![Screenshot from 2024-02-18 15-17-26](https://github.com/alexnet123/homeworks/assets/75438030/a1f24325-9c50-4706-b78c-79e76d527073)





