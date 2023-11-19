#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "vm_a" {
  name        = var.vm_a_name + "-" + tostring(count.index + 1)
  platform_id = var.vm_a_platform
  count = var.vm_a_count

  resources {
    cores  = var.vm_a_core
    memory = var.vm_a_memory
    core_fraction = var.vm_a_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_a_image
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

  # Использовать прерываемые ВМ.
  scheduling_policy { preemptible = true }

  # Временная остановка ВМ
  allow_stopping_for_update = true
}