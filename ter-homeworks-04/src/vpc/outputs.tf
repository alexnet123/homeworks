output "network_name" {
  value = var.network_name
  description = "The name of the VPC network"
}

output "network_id" {
  value = yandex_vpc_network.vpc_network.id
  description = "The ID of the VPC network"
}

output "zone" {
  value = var.zone
  description = "The zone where the subnet is deployed"
}

output "subnet_ids" {
  value = [yandex_vpc_subnet.vpc_subnet.id]
  description = "The IDs of the VPC subnets"
}
