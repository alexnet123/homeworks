terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}


# lighthouse
resource "yandex_compute_instance" "lighthouse" {
  name = "lighthouse"
  platform_id = "standard-v3" #Intel Ice Lake

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8m8s42796gm6v7sf8e"
      size = 20       
  }

}

  network_interface {
    subnet_id = "e9bfmm7ivb3taj5c2qi0"
    nat       = true
  }
   
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}

# vector
resource "yandex_compute_instance" "vector" {
  name = "vector"
  platform_id = "standard-v3" #Intel Ice Lake

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8m8s42796gm6v7sf8e"
      size = 20       
  }

}

  network_interface {
    subnet_id = "e9bfmm7ivb3taj5c2qi0"
    nat       = true
  }
   
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}

# clickhouse
resource "yandex_compute_instance" "clickhouse" {
  name = "clickhouse"
  platform_id = "standard-v3" #Intel Ice Lake

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8gvgtf1t3sbtt4opo6"
      size = 20       
  }

}

  network_interface {
    subnet_id = "e9bfmm7ivb3taj5c2qi0"
    nat       = true
  }
   
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}


 resource "local_file" "hosts" {
  content = templatefile("hosts.tmpl",
    {
     external_ip_address_vm1 = yandex_compute_instance.lighthouse.network_interface.0.nat_ip_address        
     user_vm1 = "admin"
     hostname_vm1 = "lighthouse"
     
     external_ip_address_vm2 = yandex_compute_instance.clickhouse.network_interface.0.nat_ip_address        
     user_vm2 = "admin"
     hostname_vm2 = "clickhouse"

     external_ip_address_vm3 = yandex_compute_instance.vector.network_interface.0.nat_ip_address        
     user_vm3 = "admin"
     hostname_vm3 = "vector"
    }
  )
  filename = "../hosts"
}
