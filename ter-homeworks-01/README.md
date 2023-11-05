```
root@debian:/home/alex/test/ter-homeworks/01/src# terraform -v
Terraform v1.5.7
on linux_amd64
+ provider registry.terraform.io/hashicorp/random v3.5.1
+ provider registry.terraform.io/kreuzwerker/docker v3.0.2

Your version of Terraform is out of date! The latest version
is 1.6.3. You can update by downloading from https://www.terraform.io/downloads.html

```

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
```
personal.auto.tfvars
```
3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
```
"result": "GLyjFdrOawX5w1Or",
```
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
```
random_password.random_string.result
```
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.
```
root@debian:/home/alex/test/ter-homeworks/01/src# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
492794f1fcfb   c20060033e06   "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:8000->80/tcp   example_GLyjFdrOawX5w1Or

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"
  ports {
    internal = 80
    external = 8000
  }
}

```

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. В качестве ответа дополнительно приложите вывод команды ```docker ps```.
```
root@debian:/home/alex/test/ter-homeworks/01/src# docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
aee4bdc7a04a   c20060033e06   "/docker-entrypoint.…"   36 seconds ago   Up 35 seconds   0.0.0.0:8000->80/tcp   hello_world

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "hello_world"
  ports {
    internal = 80
    external = 8000
  }
}
```

```
Если вы случайно или злоумышленно выполните команду Terraform с -auto-approve, она автоматически применит все изменения, включая создание, изменение или удаление ресурсов.
```

8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
```
{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 19,
  "lineage": "9725a208-dcbc-08dd-5ee3-175a4488fbf8",
  "outputs": {},
  "resources": [],
  "check_results": null
}

```
9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **обязательно** подкрепите строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )
```
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
```

### Задание 2*

1. Изучите в документации provider [**Virtualbox**](https://docs.comcloud.xyz/providers/shekeriev/virtualbox/latest/docs) от 
shekeriev.
2. Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN, советуем выбрать любой образ с расположением в GitHub из [**списка**](https://www.vagrantbox.es/).

В качестве ответа приложите plan для создаваемого ресурса и скриншот созданного в VB ресурса. 



```
terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  # delay      = 60
  # mintimeout = 5
}

resource "virtualbox_vm" "vm1" {
  name   = "deb12"
  image  = "https://app.vagrantup.com/shekeriev/boxes/debian-11/versions/0.2/providers/virtualbox.box"
  cpus      = 2
  memory    = "2048 mib"
  user_data = "/home/alex/test/vb"

  network_adapter {
    type           = "bridged"
    device         = "IntelPro1000MTDesktop"
    host_interface = "wlp5s0"
    # On Windows use this instead
    # host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddress" {
   value = element(virtualbox_vm.vm1.*.network_adapter.0.ipv4_address, 1)
 }
 
```