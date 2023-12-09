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

variable "public_key" {
  type    = string  
  description = "ssh key"
}

# VM vm_a VARS (web)
#========================================================
variable "vm_a_count" {
  type        = string
  default     = 2
  description = "VPC core fraction"  
}

variable "vm_a_image" {
  type        = string
  default     = "fd8pf6624ff60n2pa1qk"
  description = "VPC image" 
}

variable "vm_a_name" {
  type        = string
  default     = "web"
  description = "VPC name" 
}

variable "vm_a_platform" {
  type        = string
  default     = "standard-v3"
  description = "VPC platform_id"  
}

variable "vm_a_core" {
  type        = string
  default     = 2
  description = "VPC core"  
}

variable "vm_a_memory" {
  type        = string
  default     = 2
  description = "VPC memory GB"  
}

variable "vm_a_core_fraction" {
  type        = string
  default     = 20
  description = "VPC core fraction"  
}

# variable "vm_a_resources" {
#   type    = map
#   default = {
#     cores         = 2
#     memory        = 2
#     core_fraction = 20
#   }
# }

#========================================================




# VM disk VARS (
#========================================================
variable "disk_count" {
  type        = string
  default = 3
  description = "disk count"
}

variable "disk_size_gb" {
  type        = string
  default = 10
  description = "disk size"
}

variable "disk_name" {
  type        = string
  default = "disk"
  description = "disk name"
}


variable "vm_disk_count" {
  type        = string
  default     = 2
  description = "VPC core fraction"  
}

variable "vm_disk_image" {
  type        = string
  default     = "fd8pf6624ff60n2pa1qk"
  description = "VPC image" 
}

variable "vm_disk_name" {
  type        = string
  default     = "storage"
  description = "VPC name" 
}

variable "vm_disk_platform" {
  type        = string
  default     = "standard-v3"
  description = "VPC platform_id"  
}

variable "vm_disk_core" {
  type        = string
  default     = 2
  description = "VPC core"  
}

variable "vm_disk_memory" {
  type        = string
  default     = 2
  description = "VPC memory GB"  
}

variable "vm_disk_core_fraction" {
  type        = string
  default     = 20
  description = "VPC core fraction"  
}

# variable "vm_disk_resources" {
#   type    = map
#   default = {
#     cores         = 2
#     memory        = 2
#     core_fraction = 20
#   }
# }

#========================================================



# VM  main,replica VARS 
#========================================================
variable "virtual_machines" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  default = [
    {
      vm_name = "main"
      cpu     = 4
      ram     = 4
      disk    = 20
      core_fraction = 20
      platform_id = "standard-v3"
      image_id = "fd8pf6624ff60n2pa1qk"
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 4
      disk    = 20
      core_fraction = 20
      platform_id = "standard-v3"
      image_id = "fd8pf6624ff60n2pa1qk"
    },
  ]
}

#========================================================