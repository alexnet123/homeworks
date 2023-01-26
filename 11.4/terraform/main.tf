terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
 required_version = ">= 0.13"
}

provider "yandex" {
 
  token     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  cloud_id  = "xxxxxxxxxxxxxxxxxxxx"
  folder_id = "xxxxxxxxxxxxxxxxxxxx"
  zone      = "ru-central1-a"

}


#vm1#####################################################
resource "yandex_compute_instance" "rabbitmq1" {
  name = "rabbitmq1"
  hostname    = "rabbitmq1"
  platform_id = "standard-v3" #Intel Ice Lake

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8m8s42796gm6v7sf8e"
      size = 20       
  }

}

  network_interface {
    subnet_id = "e9b8fq1qlnj7mb6r5rgf"
    nat       = true
  }
   
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}
#vm1#####################################################


# output "internal_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.ip_address
# }

# output "external_ip_address_vm_1" {
#   value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
# }


 resource "local_file" "hosts" {
  content = templatefile("hosts.tmpl",
    {
     external_ip_address_vm1 = yandex_compute_instance.rabbitmq1.network_interface.0.nat_ip_address
     user_vm1 = "admin"
     hostname_vm1 = "rabbitmq1"
    }
  )
  filename = "/home/alex/docs/iac/iac-yandex-terraform/RabbitMQ/templates/ansible/hosts"
}
