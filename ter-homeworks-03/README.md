# Домашнее задание к занятию «Управляющие конструкции в коде Terraform» Вахрамеев А.В.

### Цели задания

1. Отработать основные принципы и методы работы с управляющими конструкциями Terraform.
2. Освоить работу с шаблонизатором Terraform (Interpolation Syntax).

------

### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Доступен исходный код для выполнения задания в директории [**03/src**](https://github.com/netology-code/ter-homeworks/tree/main/03/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Консоль управления Yandex Cloud](https://console.cloud.yandex.ru/folders/<cloud_id>/vpc/security-groups).
2. [Группы безопасности](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav).
3. [Datasource compute disk](https://terraform-eap.website.yandexcloud.net/docs/providers/yandex/d/datasource_compute_disk.html).

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** =1.5.5 (версия 1.6 может вызывать проблемы с Яндекс провайдером)
Теперь пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Изучите проект.
2. Заполните файл personal.auto.tfvars.
3. Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

Примечание. Если у вас не активирован preview-доступ к функционалу «Группы безопасности» в Yandex Cloud, запросите доступ у поддержки облачного провайдера. Обычно его выдают в течение 24-х часов.

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud или скриншот отказа в предоставлении доступа к preview-версии.

![Screenshot from 2023-11-12 06-21-29](https://github.com/alexnet123/homeworks/assets/75438030/a2dd2a7e-a981-416b-8ace-156694863e80)


------

### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )

![Screenshot from 2023-11-12 07-58-09](https://github.com/alexnet123/homeworks/assets/75438030/91f3bb4c-578a-4987-95e4-cf2d8afb1714)

```
#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "web" {
  name        = "web-${count.index + 1}"  
  platform_id = "standard-v3"
  count = 2

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pf6624ff60n2pa1qk" 
      type = "network-hdd"
      size = 5
    }   
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  # ИЫспользовать прерываемые ВМ.
  scheduling_policy { preemptible = true }

  # Временная остановка ВМ
  allow_stopping_for_update = true
}

```

3. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ с именами "main" и "replica" **разных** по cpu/ram/disk , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number  })). При желании внесите в переменную все возможные параметры.
4. ВМ из пункта 2.2 должны создаваться после создания ВМ из пункта 2.1.
5. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
6. Инициализируйте проект, выполните код.

![Screenshot from 2023-11-12 20-25-52](https://github.com/alexnet123/homeworks/assets/75438030/c6044b4d-b479-4ad7-ad39-c2348af3bd04)

```
variable "virtual_machines" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 4
      ram     = 4
      disk    = 20
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 4
      disk    = 20
    },
  ]
}

resource "yandex_compute_instance" "vm" {
  for_each = { for vm in var.virtual_machines : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = "standard-v3"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pf6624ff60n2pa1qk"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh_public_key}"

  }

  # Использовать прерываемые ВМ.
  scheduling_policy { preemptible = true }

  # Временная остановка ВМ
  allow_stopping_for_update = true

  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.vm_a]
}



```
------

### Задание 3

1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .
2. Создайте в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.



![Screenshot from 2023-11-12 21-05-09](https://github.com/alexnet123/homeworks/assets/75438030/da84dd8d-e432-4327-956d-c7d3b4b7b874)


```
variable "disk_count" {
  default = 3
}

variable "disk_size_gb" {
  default = 10
}

resource "yandex_compute_disk" "vm_disk" {
  count = var.disk_count

  name  = "disk-${count.index + 1}"
  size  = var.disk_size_gb


}

resource "yandex_compute_instance" "storage_vm" {
  name         = "storage"
  platform_id  = "standard-v3"
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pf6624ff60n2pa1qk"
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm_disk

    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }

  # Использовать прерываемые ВМ.
  scheduling_policy { preemptible = true }

  # Временная остановка ВМ
  allow_stopping_for_update = true
}
```

------

### Задание 4

1. В файле ansible.tf создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demonstration2).
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
2. Инвентарь должен содержать 3 группы [webservers], [databases], [storage] и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.
4. Выполните код. Приложите скриншот получившегося файла. 

Для общего зачёта создайте в вашем GitHub-репозитории новую ветку terraform-03. Закоммитьте в эту ветку свой финальный код проекта, пришлите ссылку на коммит.   
**Удалите все созданные ресурсы**.

```
resource "local_file" "ansible_inventory" {
  content  = templatefile("inventory.tpl", {
    webservers = yandex_compute_instance.vm,
    databases  = yandex_compute_instance.vm_a,
    storage    = [yandex_compute_instance.storage_vm],
  })

  filename = "hosts"
}
```
```

[databases]
%{ for instance in webservers ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}

[webservers]
%{ for instance in databases ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}

[storage]
%{ for instance in storage ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}

```




------

## Дополнительные задания (со звездочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

### Задание 5* (необязательное)
1. Напишите output, который отобразит все 5 созданных ВМ в виде списка словарей:
``` 
[
 {
  "name" = 'имя ВМ1'
  "id"   = 'идентификатор ВМ1'
  "fqdn" = 'Внутренний FQDN ВМ1'
 },
 {
  "name" = 'имя ВМ2'
  "id"   = 'идентификатор ВМ2'
  "fqdn" = 'Внутренний FQDN ВМ2'
 },
 ....
]
```
Приложите скриншот вывода команды ```terrafrom output```.

![Screenshot from 2023-11-12 23-51-40](https://github.com/alexnet123/homeworks/assets/75438030/20e90c0c-7b82-4d69-a3b5-41b7f301a1d1)


------

### Задание 6* (необязательное)

1. Используя null_resource и local-exec, примените ansible-playbook к ВМ из ansible inventory-файла.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/demonstration2).
3. Дополните файл шаблон hosts.tftpl. 
Формат готового файла:
```netology-develop-platform-web-0   ansible_host="<внешний IP-address или внутренний IP-address если у ВМ отсутвует внешний адрес>"```

Для проверки работы уберите у ВМ внешние адреса. Этот вариант используется при работе через bastion-сервер.
Для зачёта предоставьте код вместе с основной частью задания.

### Правила приёма работы

В своём git-репозитории создайте новую ветку terraform-03, закоммитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-03.

В качестве результата прикрепите ссылку на ветку terraform-03 в вашем репозитории.

Важно. Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 
