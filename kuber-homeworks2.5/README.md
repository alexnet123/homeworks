# Домашнее задание к занятию «Helm» Вахрамеев А.В.

---

# Задание 1. Подготовить Helm-чарт для приложения

```
root@master0-ru-central1-a:/home/admin/myapp# helm create app
Creating app
root@master0-ru-central1-a:/home/admin/myapp# ls
app
root@master0-ru-central1-a:/home/admin/myapp# cd app/
root@master0-ru-central1-a:/home/admin/myapp/app# ls
charts	Chart.yaml  templates  values.yaml

```

```
root@master0-ru-central1-a:/home/admin/myapp# k create namespace app1
namespace/app1 created
root@master0-ru-central1-a:/home/admin/myapp# k create namespace app2
namespace/app2 created

```

# Задание 2. Запустить две версии в разных неймспейсах

### namespace app1

```
root@master0-ru-central1-a:/home/admin/myapp# helm install web3 -n app1 --set image.tag=1.16 app/
root@master0-ru-central1-a:/home/admin/myapp# helm install web2 -n app1 --set image.tag=1.16 app/
root@master0-ru-central1-a:/home/admin/myapp# helm install web3 -n app1 --set image.tag=1.17 app/

```

```
root@master0-ru-central1-a:/home/admin/myapp# k get pod -n app1 -o yaml | grep imag
    - image: nginx:1.16.0
      imagePullPolicy: IfNotPresent
      image: docker.io/library/nginx:1.16.0
      imageID: docker.io/library/nginx@sha256:3e373fd5b8d41baeddc24be311c5c6929425c04cabf893b874ac09b72a798010
    - image: nginx:1.16.0
      imagePullPolicy: IfNotPresent
      image: docker.io/library/nginx:1.16.0
      imageID: docker.io/library/nginx@sha256:3e373fd5b8d41baeddc24be311c5c6929425c04cabf893b874ac09b72a798010
    - image: nginx:1.17
      imagePullPolicy: IfNotPresent
      image: docker.io/library/nginx:1.17
      imageID: docker.io/library/nginx@sha256:6fff55753e3b34e36e24e37039ee9eae1fe38a6420d8ae16ef37c92d1eb26699
root@master0-ru-central1-a:/home/admin/myapp# helm list -n app1
NAME	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART    	APP VERSION
web1	app1     	1       	2024-03-27 11:50:03.763072071 +0000 UTC	deployed	app-0.1.0	1.16.0     
web2	app1     	1       	2024-03-27 11:53:09.492241702 +0000 UTC	deployed	app-0.1.0	1.16.0     
web3	app1     	1       	2024-03-27 12:00:19.233316614 +0000 UTC	deployed	app-0.1.0	1.16.0     
root@master0-ru-central1-a:/home/admin/myapp# 


```
```
root@master0-ru-central1-a:/home/admin/myapp# k get pod -n app1
NAME                        READY   STATUS    RESTARTS   AGE
web1-app-67d99b9544-qtrb5   1/1     Running   0          35m
web2-app-7b7f95fdd7-d27cz   1/1     Running   0          32m
web3-app-f97564955-pk54r    1/1     Running   0          24m
```

### namespace app2

```
root@master0-ru-central1-a:/home/admin/myapp# helm install web3 -n app2 --set image.tag=1.17 app/
root@master0-ru-central1-a:/home/admin/myapp# helm install web4 -n app2 --set image.tag=1.18 app/
```

```
root@master0-ru-central1-a:/home/admin/myapp# k get pod -n app2 -o yaml | grep imag
    - image: nginx:1.17
      imagePullPolicy: IfNotPresent
      image: docker.io/library/nginx:1.17
      imageID: docker.io/library/nginx@sha256:6fff55753e3b34e36e24e37039ee9eae1fe38a6420d8ae16ef37c92d1eb26699
    - image: nginx:1.18
      imagePullPolicy: IfNotPresent
    - image: nginx:1.18
      imageID: ""
```

```
root@master0-ru-central1-a:/home/admin/myapp# helm list -n app2
NAME	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART    	APP VERSION
web3	app2     	1       	2024-03-27 12:04:18.912332292 +0000 UTC	deployed	app-0.1.0	1.16.0     
web4	app2     	1       	2024-03-27 12:04:59.38811975 +0000 UTC 	deployed	app-0.1.0	1.16.0     

```

```
root@master0-ru-central1-a:/home/admin/myapp# k get pod -n app2
NAME                        READY   STATUS    RESTARTS   AGE
web3-app-f97564955-qz2r9    1/1     Running   0          20m
web4-app-56859c4cb5-wmfbq   1/1     Running   0          20m
```
