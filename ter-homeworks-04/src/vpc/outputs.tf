# output "network_name" {
#   value = var.network_name
#   description = "The name of the VPC network"
# }

# output "network_id" {
#   value = yandex_vpc_network.vpc_network.id
#   description = "The ID of the VPC network"
# }

# output "zone" {
#   value = var.zone
#   description = "The zone where the subnet is deployed"
# }

# output "subnet_ids" {
#   value = [yandex_vpc_subnet.vpc_subnet.id]
#   description = "The IDs of the VPC subnets"
# }

# output "subnets" {
#   value = yandex_vpc_subnet.vpc_subnet
#   description = "The created subnet resources"
# }

output "network_name" {
  value       = var.network_name
  description = "The name of the VPC network"
}

output "network_id" {
  value       = yandex_vpc_network.vpc_network.id
  description = "The ID of the VPC network"
}

output "subnets_info" {
  value = [for subnet in yandex_vpc_subnet.vpc_subnet : {
    id   = subnet.id
    zone = subnet.zone
  }]
  description = "Information about the created subnets including their IDs and zones"
}

