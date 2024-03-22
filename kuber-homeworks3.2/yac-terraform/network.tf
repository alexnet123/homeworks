resource "yandex_vpc_network" "kub_net" {
  name = var.trf_net_name
}

resource "yandex_vpc_subnet" "kub_net_subnet_a" {
  v4_cidr_blocks = var.trf_web_net_subnet_kub_a_cidrs
  name           = var.trf_web_net_subnet_kub_a_name
  zone           = var.trf_zone_a
  network_id     = yandex_vpc_network.kub_net.id
}
