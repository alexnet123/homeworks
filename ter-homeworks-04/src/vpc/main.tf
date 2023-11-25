# resource "yandex_vpc_network" "vpc_network" {
#   name = var.network_name
# }

# resource "yandex_vpc_subnet" "vpc_subnet" {
#   name           = "${var.network_name}-subnet"
#   zone           = var.zone
#   network_id     = yandex_vpc_network.vpc_network.id
#   v4_cidr_blocks = var.v4_cidr_blocks
# }

resource "yandex_vpc_network" "vpc_network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "vpc_subnet" {
  for_each = { for s in var.subnets : "${s.zone}-${s.cidr}" => s }

  name           = "${var.network_name}-subnet-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = [each.value.cidr]
}