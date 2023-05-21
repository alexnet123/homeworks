resource "yandex_compute_instance" "node01" {
  
  zone =  var.trf_zone_a
  hostname = "${var.trf_node01_name}${count.index}-${var.trf_zone_a}"
  name =     "${var.trf_node01_name}${count.index}-${var.trf_zone_a}"
  platform_id = var.trf_node01_platform_id
  count = var.trf_node01_count



resources {
    cores  = var.trf_node01_cores
    memory = var.trf_node01_memory
  }

boot_disk {
    initialize_params {
      image_id = var.trf_node01_image_id
      size = var.trf_node01_disc_size     
  }

}

network_interface {
    subnet_id = yandex_vpc_subnet.test_net2_net_subnet_a.id 
    nat       = var.trf_node01_nat
    ipv6      = var.trf_node01_ipv6
  }
   

  metadata = {
    user-data = <<-EOF
    #cloud-config
    ssh_pwauth: no
    users:
      - name: ${var.trf_node01_user}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${var.trf_mng_node01_public_key} 
    EOF
  }

allow_stopping_for_update = true

}

