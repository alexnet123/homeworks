resource "yandex_vpc_network" "test_net2" {
  name = var.trf_net_name
}

resource "yandex_vpc_subnet" "test_net2_net_subnet_a" {
  v4_cidr_blocks = var.trf_web_net_subnet_test_net2_a_cidrs
  name           = var.trf_web_net_subnet_test_net2_a_name
  zone           = var.trf_zone_a
  network_id     = yandex_vpc_network.test_net2.id
}

