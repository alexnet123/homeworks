# Домашнее задание к занятию «Запуск приложений в K8S» Вахрамеев А.В.

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-multitool-deployment
spec:
  replicas: 1
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

2. После запуска увеличить количество реплик работающего приложения до 2.

```
root@master0-ru-central1-a:/home/admin# kubectl scale deployment nginx-multitool-deployment --replicas=2
deployment.apps/nginx-multitool-deployment scaled

```

3. Продемонстрировать количество подов до и после масштабирования.

```
root@master0-ru-central1-a:/home/admin# kubectl get pods
NAME                                         READY   STATUS    RESTARTS   AGE
nginx-multitool-deployment-88cf96565-jgtnc   2/2     Running   0          20s
root@master0-ru-central1-a:/home/admin# vim deployment1.yaml 
root@master0-ru-central1-a:/home/admin# kubectl get deployment
NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
nginx-multitool-deployment   1/1     1            1           64s
root@master0-ru-central1-a:/home/admin# kubectl scale deployment nginx-multitool-deployment --replicas=2
deployment.apps/nginx-multitool-deployment scaled
root@master0-ru-central1-a:/home/admin# kubectl get pods
NAME                                         READY   STATUS    RESTARTS   AGE
nginx-multitool-deployment-88cf96565-4kfgz   2/2     Running   0          5s
nginx-multitool-deployment-88cf96565-jgtnc   2/2     Running   0          104s

```


4. Создать Service, который обеспечит доступ до реплик приложений из п.1.

```
apiVersion: v1
kind: Service
metadata:
  name: nginx-multitool-service
spec:
  type: NodePort
  ports:
    - name: nginx-port
      port: 80
      targetPort: 80
      nodePort: 30080 
    - name: multitool-port
      port: 1180
      targetPort: 1180
      nodePort: 30180 
  selector:
    app: nginx-multitool

```

```
root@master0-ru-central1-a:/home/admin# kubectl get svc
NAME                      TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)                       AGE
kubernetes                ClusterIP   10.96.0.1     <none>        443/TCP                       3h41m
nginx-multitool-service   NodePort    10.108.0.60   <none>        80:30080/TCP,1180:30180/TCP   8s

```

5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

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
root@master0-ru-central1-a:/home/admin# kubectl apply -f multitool-pod1.yaml 
pod/multitool-pod created
root@master0-ru-central1-a:/home/admin# kubectl get pods
NAME                                         READY   STATUS    RESTARTS   AGE
multitool-pod                                1/1     Running   0          3s
nginx-multitool-deployment-88cf96565-4kfgz   2/2     Running   0          118s
nginx-multitool-deployment-88cf96565-jgtnc   2/2     Running   0          3m37s
root@master0-ru-central1-a:/home/admin# kubectl exec multitool-pod -- curl nginx-multitool-service
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615    0     0   261k      0 --:--:-- --:--:-- --:--:--  300k
<!DOCTYPE html>
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

```

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.
