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
root@master0-ru-central1-a:/home/admin/myapp# k create namespace web
namespace/web created

```

```

root@master0-ru-central1-a:/home/admin/myapp# helm install web1 -n web app/
NAME: web1
LAST DEPLOYED: Wed Mar 27 11:21:21 2024
NAMESPACE: web
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace web -l "app.kubernetes.io/name=app,app.kubernetes.io/instance=web1" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace web $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace web port-forward $POD_NAME 8080:$CONTAINER_PORT
root@master0-ru-central1-a:/home/admin/myapp# 
root@master0-ru-central1-a:/home/admin/myapp# k get pod -n web 
NAME                        READY   STATUS    RESTARTS   AGE
web1-app-67d99b9544-t4hlj   1/1     Running   0          2m29s
root@master0-ru-central1-a:/home/admin/myapp# 
root@master0-ru-central1-a:/home/admin/myapp#

```
