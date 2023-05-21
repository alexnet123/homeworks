resource "yandex_compute_instance" "node02" {
  
  zone =  var.trf_zone_a
  hostname = "${var.trf_node02_name}${count.index}-${var.trf_zone_a}"
  name =     "${var.trf_node02_name}${count.index}-${var.trf_zone_a}"
  platform_id = var.trf_node02_platform_id
  count = var.trf_node02_count



resources {
    cores  = var.trf_node02_cores
    memory = var.trf_node02_memory
  }

boot_disk {
    initialize_params {
      image_id = var.trf_node02_image_id
      size = var.trf_node02_disc_size     
  }

}

network_interface {
    subnet_id = yandex_vpc_subnet.test_net2_net_subnet_a.id 
    nat       = var.trf_node02_nat
    ipv6      = var.trf_node02_ipv6
  }
   

  metadata = {
    user-data = <<-EOF
    #cloud-config
    ssh_pwauth: no
    users:
      - name: ${var.trf_node02_user}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${var.trf_mng_node02_public_key} 
    EOF
  }

allow_stopping_for_update = true

}

