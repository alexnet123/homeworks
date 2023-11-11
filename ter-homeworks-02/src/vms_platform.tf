# VM WEB VARS
#========================================================
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VPC image" 
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VPC name" 
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v3"
  description = "VPC platform_id"  
}

variable "vm_web_core" {
  type        = string
  default     = 2
  description = "VPC core"  
}

variable "vm_web_memory" {
  type        = string
  default     = 4
  description = "VPC memory GB"  
}

variable "vm_web_core_fraction" {
  type        = string
  default     = 50
  description = "VPC core fraction"  
}

variable "vm_web_resources" {
  type    = map
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 50
  }
}

#========================================================


# VM DB VARS
#========================================================
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VPC image" 
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VPC name" 
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v3"
  description = "VPC platform_id"  
}

variable "vm_db_core" {
  type        = string
  default     = 2
  description = "VPC core"  
}

variable "vm_db_memory" {
  type        = string
  default     = 2
  description = "VPC memory GB"  
}

variable "vm_db_core_fraction" {
  type        = string
  default     = 20
  description = "VPC core fraction"  
}

variable "vm_db_resources" {
  type    = map
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

#========================================================

# metadata
#========================================================
variable "vms_metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxuZp+FqjaFpSAeHJzYIFjYd7rw8n0JkUo9D09/bOQoloelC+dfPug5SOpSwgwDej6QTvJYTpUlw9y3JoqBjq+A6ygTNUbIrXC95rLwfwgs7bEQbrtYQhu1bxao/H/6yBWgkzl3T2J3lzi+hyAZ8bma07RZyWnJjXsiRL8ovTrv6uGyq9noFG1YFBSMl6V+fhSR+rg1aaKq9u0hH00ouuxI4ggsKY/vvLhQq1faCgjv6axZ3Wy/b0mugwrWuK5K8jEmae/AtusSID3OB5jsVaGOYRvNZCWLcwIB+NguY1A0/+5IVlpG4C0LjQ03jgyB3unbm9c4HMZJFvm3u4Ka0RsEXzaHs4gFPN5JzOWbMzAxXRHrko+Z3WepQc6uf2diMYCzTb9B31yiXqFLY0eTy/BYKjsvvjVvBh5nKv7KFp0651SkLSbjXHExEnFhZ+1cILcrvkhLNNkxCo7AgP7GLUQ1v8T6UOzfEUy0b++D/F0rP1qY/Ircs8+7fIN/wi0/sU="
  } 
} 

#========================================================
