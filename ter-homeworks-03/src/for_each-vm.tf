
resource "yandex_compute_instance" "vm" {
  for_each = { for vm in var.virtual_machines : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = each.value.platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id
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




