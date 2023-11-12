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




