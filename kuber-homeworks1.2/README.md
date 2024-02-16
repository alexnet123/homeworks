# Домашнее задание к занятию «Базовые объекты K8S» Вахрамеев А.В.

## Задание 1. Создать Pod с именем hello-world

1. **Создание манифеста (yaml-конфигурации) Pod**

    Создан файл `hello-world-pod.yaml` со следующим содержанием:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: hello-world
    spec:
      containers:
      - name: echoserver
        image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
        ports:
        - containerPort: 8080
    ```

    Этот манифест описывает Pod, который запускает контейнер с образом `echoserver:2.2`.

2. **Использование образа `gcr.io/kubernetes-e2e-test-images/echoserver:2.2`**

    В манифесте Pod указан образ `echoserver:2.2` от `gcr.io/kubernetes-e2e-test-images`.

3. **Подключение локально к Pod с помощью `kubectl port-forward`**

    Для подключения к Pod использована команда:

    ```
    kubectl port-forward pod/hello-world 8080:8080
    ```

    Это позволило локально подключиться к `hello-world` Pod и проверить его работу с использованием `curl` или веб-браузера по адресу `http://localhost:8080`.

![Screenshot from 2024-02-16 23-03-31](https://github.com/alexnet123/homeworks/assets/75438030/6af2cdf5-c597-4ee1-9726-13b44cb4d4e0)


## Задание 2. Создать Service и подключить его к Pod

1. **Создание Pod с именем netology-web**

    Создан файл `netology-web-pod.yaml` с подом `netology-web-pod`, использующим тот же образ `echoserver:2.2`:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: netology-web-pod
      labels:
        app: netology-web
    spec:
      containers:
      - name: echoserver
        image: gcr.io/kubernetes-e2e-test-images/echoserver:2.2
        ports:
        - containerPort: 8080
    ```

    Для пода установлена метка `app: netology-web`, чтобы Service мог его идентифицировать.

2. **Использование образа `gcr.io/kubernetes-e2e-test-images/echoserver:2.2` для Pod `netology-web`**

    В манифесте Pod `netology-web-pod` указан тот же образ `echoserver:2.2`.

3. **Создание Service с именем netology-svc и подключение к netology-web**

    Создан файл `netology-svc.yaml` для Service `netology-svc`, который направляет трафик на Pod `netology-web-pod`:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: netology-svc
    spec:
      selector:
        app: netology-web
      ports:
        - protocol: TCP
          port: 80
          targetPort: 8080
    ```

    Этот Service использует селектор `app: netology-web` для идентификации и перенаправления трафика к соответствующему Pod.

4. **Подключение локально к Service с помощью `kubectl port-forward`**

    Для подключения к Service использована команда:

    ```
    kubectl port-forward service/netology-svc 8080:80
    ```

    Это позволило локально подключиться к `netology-svc` и проверить его работу с использованием `curl` или веб-браузера по адресу `http://localhost:8080`.

![Screenshot from 2024-02-16 23-32-58](https://github.com/alexnet123/homeworks/assets/75438030/b59027b6-8773-4a53-9573-e2dc66cbf195)
