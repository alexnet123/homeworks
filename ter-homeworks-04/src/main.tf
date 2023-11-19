#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = var.network_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = var.subnet_name
  zone           = var.subnet_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnet_cidr_block]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = var.network_name
  network_id      = yandex_vpc_network.develop.id
  subnet_zones    = [var.subnet_zone]
  subnet_ids      = [yandex_vpc_subnet.develop.id]
  instance_name   = var.vm_web_instance_name
  instance_count  = var.vm_web_instance_count
  image_family    = var.vm_web_image_family
  public_ip       = var.vm_web_public_ip
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = local.ssh_public_key
  }
}
