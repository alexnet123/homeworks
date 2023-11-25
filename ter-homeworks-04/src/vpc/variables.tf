# variable "network_name" {
#   description = "The name of the VPC network"
#   type        = string
# }

# variable "zone" {
#   description = "The availability zone"
#   type        = string
# }

# variable "v4_cidr_blocks" {
#   description = "CIDR block for the subnet"
#   type        = list(string)
# }

# variable "subnets" {
#   description = "List of subnets to create"
#   type        = list(object({
#     zone = string
#     cidr = string
#   }))
# }


variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnets" {
  description = "List of subnets to create"
  type        = list(object({
    zone = string
    cidr = string
  }))
}