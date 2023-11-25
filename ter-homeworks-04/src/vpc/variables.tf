variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "zone" {
  description = "The availability zone"
  type        = string
}

variable "v4_cidr_blocks" {
  description = "CIDR block for the subnet"
  type        = list(string)
}