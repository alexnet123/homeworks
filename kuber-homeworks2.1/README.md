# Домашнее задание к занятию «Хранение в K8s. Часть 1» Вахрамеев А.В.

### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-multitool
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox-multitool
  template:
    metadata:
      labels:
        app: busybox-multitool
    spec:
      volumes:
      - name: shared-data
        emptyDir: {}
      containers:
      - name: busybox
        image: busybox
        volumeMounts:
        - name: shared-data
          mountPath: /data
        command: ["/bin/sh"]
        args:
        - -c
        - while true; do date >> /data/log.txt; sleep 5; done
      - name: multitool
        image: praqma/network-multitool
        volumeMounts:
        - name: shared-data
          mountPath: /data

```

```

root@master0-ru-central1-a:/home/admin# kubectl get pods 
NAME                                 READY   STATUS    RESTARTS   AGE
busybox-multitool-5d8d79c79d-7mbwr   2/2     Running   0          9m45s

```
```
root@master0-ru-central1-a:/home/admin# kubectl exec busybox-multitool-5d8d79c79d-7mbwr -c multitool -- cat /data/log.txt
Sun Feb 18 14:37:16 UTC 2024
Sun Feb 18 14:37:21 UTC 2024
Sun Feb 18 14:37:26 UTC 2024
Sun Feb 18 14:37:31 UTC 2024
Sun Feb 18 14:37:36 UTC 2024
Sun Feb 18 14:37:41 UTC 2024
Sun Feb 18 14:37:46 UTC 2024

root@master0-ru-central1-a:/home/admin# kubectl exec busybox-multitool-5d8d79c79d-7mbwr -c multitool -- cat /data/log.txt
Sun Feb 18 14:37:16 UTC 2024
Sun Feb 18 14:37:21 UTC 2024
Sun Feb 18 14:37:26 UTC 2024
Sun Feb 18 14:37:31 UTC 2024
Sun Feb 18 14:37:36 UTC 2024
Sun Feb 18 14:37:41 UTC 2024
Sun Feb 18 14:37:46 UTC 2024
Sun Feb 18 14:37:51 UTC 2024
Sun Feb 18 14:37:56 UTC 2024
Sun Feb 18 14:38:01 UTC 2024
Sun Feb 18 14:38:06 UTC 2024
Sun Feb 18 14:38:11 UTC 2024
Sun Feb 18 14:38:16 UTC 2024
Sun Feb 18 14:38:21 UTC 2024
Sun Feb 18 14:38:26 UTC 2024
Sun Feb 18 14:38:31 UTC 2024

```

------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.

```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: multitool-daemonset
spec:
  selector:
    matchLabels:
      name: multitool
  template:
    metadata:
      labels:
        name: multitool
    spec:
      containers:
      - name: multitool
        image: praqma/network-multitool
        volumeMounts:
        - name: var-log
          mountPath: /host/var/log
      volumes:
      - name: var-log
        hostPath:
          path: /var/log
```

```

root@master0-ru-central1-a:/home/admin# kubectl get pods -o wide 
NAME                                 READY   STATUS    RESTARTS   AGE     IP          NODE                    NOMINATED NODE   READINESS GATES
busybox-multitool-5d8d79c79d-7mbwr   2/2     Running   0          11m     10.0.1.88   worker1-ru-central1-a   <none>           <none>
multitool-daemonset-jh9r9            1/1     Running   0          8m18s   10.0.0.59   worker0-ru-central1-a   <none>           <none>
multitool-daemonset-mxrll            1/1     Running   0          8m18s   10.0.1.57   worker1-ru-central1-a   <none>           <none>

```
```
root@master0-ru-central1-a:/home/admin# kubectl exec multitool-daemonset-mxrll -- cat /host/var/log/syslog | tail -n 5
Feb 18 14:40:50 worker1-ru-central1-a containerd[13981]: time="2024-02-18T14:40:50.625361788Z" level=info msg="StartContainer for \"2860ebed8ea1b75881e0cb360bc353c50189d09da01580e979967e9acc980770\""
Feb 18 14:40:50 worker1-ru-central1-a containerd[13981]: time="2024-02-18T14:40:50.734449078Z" level=info msg="StartContainer for \"2860ebed8ea1b75881e0cb360bc353c50189d09da01580e979967e9acc980770\" returns successfully"
Feb 18 14:40:51 worker1-ru-central1-a kubelet[16986]: I0218 14:40:51.508678   16986 pod_startup_latency_tracker.go:102] "Observed pod startup duration" pod="default/multitool-daemonset-mxrll" podStartSLOduration=2.429817377 podCreationTimestamp="2024-02-18 14:40:48 +0000 UTC" firstStartedPulling="2024-02-18 14:40:49.474513341 +0000 UTC m=+3222.197586290" lastFinishedPulling="2024-02-18 14:40:50.553324712 +0000 UTC m=+3223.276397672" observedRunningTime="2024-02-18 14:40:51.508371843 +0000 UTC m=+3224.231444811" watchObservedRunningTime="2024-02-18 14:40:51.508628759 +0000 UTC m=+3224.231701729"
Feb 18 14:40:51 worker1-ru-central1-a ntpd[8265]: Listen normally on 13 lxcc9dd18f6d818 [fe80::7cac:58ff:fe72:5911%11]:123
Feb 18 14:40:51 worker1-ru-central1-a ntpd[8265]: new interface(s) found: waking up resolver
root@master0-ru-central1-a:/home/admin# 
root@master0-ru-central1-a:/home/admin# 
root@master0-ru-central1-a:/home/admin# 
root@master0-ru-central1-a:/home/admin# kubectl exec multitool-daemonset-jh9r9 -- cat /host/var/log/syslog | tail -n 5
Feb 18 14:40:53 worker0-ru-central1-a containerd[14001]: time="2024-02-18T14:40:53.254085675Z" level=info msg="CreateContainer within sandbox \"5c511bb592ad4437edbc056985f43c38de8c62dd43e42519c25c186651c88913\" for container &ContainerMetadata{Name:multitool,Attempt:0,}"
Feb 18 14:40:53 worker0-ru-central1-a containerd[14001]: time="2024-02-18T14:40:53.327224233Z" level=info msg="CreateContainer within sandbox \"5c511bb592ad4437edbc056985f43c38de8c62dd43e42519c25c186651c88913\" for &ContainerMetadata{Name:multitool,Attempt:0,} returns container id \"11528952b90f18134459c1ae3211dcf2187961af039fea069c93329aa08da777\""
Feb 18 14:40:53 worker0-ru-central1-a containerd[14001]: time="2024-02-18T14:40:53.328241008Z" level=info msg="StartContainer for \"11528952b90f18134459c1ae3211dcf2187961af039fea069c93329aa08da777\""
Feb 18 14:40:53 worker0-ru-central1-a systemd[1]: run-containerd-runc-k8s.io-11528952b90f18134459c1ae3211dcf2187961af039fea069c93329aa08da777-runc.bl9dFM.mount: Succeeded.
Feb 18 14:40:53 worker0-ru-central1-a containerd[14001]: time="2024-02-18T14:40:53.486319055Z" level=info msg="StartContainer for \"11528952b90f18134459c1ae3211dcf2187961af039fea069c93329aa08da777\" returns successfully"
root@master0-ru-central1-a:/home/admin# 


```

------
