###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "ssh_public_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

#Network
#===============================================================
variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "develop"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "develop-ru-central1-a"
}

variable "subnet_zone" {
  description = "The zone of the subnet"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
#===============================================================


#VARS VM WEB
#===============================================================

variable "vm_web_instance_name" {
  description = "Name of the instance"
  type        = string
  default     = "web"
}

variable "vm_web_instance_count" {
  description = "Number of instances to create"
  type        = string
  default     = 1
}

variable "vm_web_image_family" {
  description = "The image family for the instance"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = true
}


#===============================================================
