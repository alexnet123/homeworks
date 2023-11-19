

resource "yandex_compute_disk" "vm_disk" {
  count = var.disk_count

  name  = var.disk_name + "-" + tostring(count.index + 1)
  size  = var.disk_size_gb


}

resource "yandex_compute_instance" "storage_vm" {
  name         = var.vm_disk_name
  platform_id  = var.vm_disk_platform
  resources {
    cores  = var.vm_disk_core
    memory = var.vm_disk_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_disk_image
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