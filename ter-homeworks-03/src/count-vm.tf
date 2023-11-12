#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "vm_a" {
  name        = "web-${count.index + 1}"  
  platform_id = "standard-v3"
  count = 2

  resources {
    cores  = 2
    memory = 4
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

  # Использовать прерываемые ВМ.
  scheduling_policy { preemptible = true }

  # Временная остановка ВМ
  allow_stopping_for_update = true
}