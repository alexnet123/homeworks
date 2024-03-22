resource "yandex_compute_instance" "vm_master" {
  
  zone =  var.trf_zone_a
  hostname = "${var.trf_vm_master_name}${count.index}-${var.trf_zone_a}"
  name =     "${var.trf_vm_master_name}${count.index}-${var.trf_zone_a}"
  platform_id = var.trf_vm_master_platform_id
  count = var.trf_vm_master_count


resources {
    cores  = var.trf_vm_master_cores
    memory = var.trf_vm_master_memory
  }

boot_disk {
    initialize_params {
      image_id = var.trf_vm_master_image_id
      size = var.trf_vm_master_disc_size     
  }

}

network_interface {
    subnet_id = yandex_vpc_subnet.kub_net_subnet_a.id
    nat       = var.trf_vm_master_nat
    ipv6      = var.trf_vm_master_ipv6
  }
   

  metadata = {
    user-data = <<-EOF
    #cloud-config
    ssh_pwauth: no
    users:
      - name: ${var.trf_vm_master_user}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${var.trf_mng_vm_master_public_key}
    EOF
  }

allow_stopping_for_update = true

}

