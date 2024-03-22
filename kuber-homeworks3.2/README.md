# Домашнее задание к занятию «Установка Kubernetes» Вахрамеев А.В.

Установку выполнял плейбуком Ansible 

![Screenshot from 2024-03-22 17-43-08](https://github.com/alexnet123/homeworks/assets/75438030/2ed1e61f-1a97-485b-a0d3-e182e8ecb9bb)

```

root@master0-ru-central1-a:/home/admin# k get nodes 
NAME                    STATUS   ROLES           AGE     VERSION
master0-ru-central1-a   Ready    control-plane   3m8s    v1.28.8
worker0-ru-central1-a   Ready    <none>          2m53s   v1.28.8
worker1-ru-central1-a   Ready    <none>          2m53s   v1.28.8
worker2-ru-central1-a   Ready    <none>          2m53s   v1.28.8
worker3-ru-central1-a   Ready    <none>          2m53s   v1.28.8
root@master0-ru-central1-a:/home/admin# 

```

### etcd запущен на мастере

```

root@master0-ru-central1-a:/home/admin# k get pods -n kube-system -l component=etcd
NAME                         READY   STATUS    RESTARTS   AGE
etcd-master0-ru-central1-a   1/1     Running   0          14m
root@master0-ru-central1-a:/home/admin# 

```

### В качестве CRI  containerd://1.7.0 ,   OS Ubuntu 20.04

```

root@master0-ru-central1-a:/home/admin# kubectl get nodes -o wide
NAME                    STATUS   ROLES           AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master0-ru-central1-a   Ready    control-plane   17m   v1.28.8   192.168.10.16   <none>        Ubuntu 20.04.6 LTS   5.4.0-173-generic   containerd://1.7.0
worker0-ru-central1-a   Ready    <none>          17m   v1.28.8   192.168.10.31   <none>        Ubuntu 20.04.6 LTS   5.4.0-173-generic   containerd://1.7.0
worker1-ru-central1-a   Ready    <none>          17m   v1.28.8   192.168.10.24   <none>        Ubuntu 20.04.6 LTS   5.4.0-173-generic   containerd://1.7.0
worker2-ru-central1-a   Ready    <none>          17m   v1.28.8   192.168.10.26   <none>        Ubuntu 20.04.6 LTS   5.4.0-173-generic   containerd://1.7.0
worker3-ru-central1-a   Ready    <none>          17m   v1.28.8   192.168.10.14   <none>        Ubuntu 20.04.6 LTS   5.4.0-173-generic   containerd://1.7.0

```
