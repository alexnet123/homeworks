# Yandex cloud region
variable "trf_zone_a" {
  type    = string
  default = "ru-central1-a" 
}

variable "trf_zone_b" {
  type    = string
  default = "ru-central1-b" 
}

# provider 
#=========================================

# Yandex cloud folder_id
variable "trf_folder_id" {
  type    = string
  default = "" 
}

# Yandex cloud cloud_id
variable "trf_cloud_id" {
  type    = string
  default = "" 
}

# Yandex cloud token
variable "trf_token" {
  type    = string
  default = "" 
}
#==========================================

# Networks
#=========================================

# Net name
variable "trf_net_name" {
  type    = string
  default = "web-kub"      
}

# Subnet web_net_subnet_a
#------------------------------------------
# CIDR
variable "trf_web_net_subnet_kub_a_cidrs" {
  type = list(string)
  default = ["192.168.10.0/24"]
}

# Name
variable "trf_web_net_subnet_kub_a_name" {
  type = string
  default = "web-kub-a"
}
#------------------------------------------


#=========================================

# VM Worker
#=========================================
# Management ssh public key
variable "trf_mng_vm_worker_public_key" {
   #type    = string
   default = ""
}

# Yandex cloud hardware platform 
# ( "standard-v3" = #Intel Ice Lake)
variable "trf_vm_worker_platform_id" {
  type    = string
  default = "standard-v3"
}

# vm name
variable "trf_vm_worker_name" {
  type    = string
  default = "worker"      
}

# vm count
variable "trf_vm_worker_count" {
  type    = string
  default = "4"      
}

# vm user
variable "trf_vm_worker_user" {
  type    = string
  default = "admin"      
}

# vm memory 
variable "trf_vm_worker_memory" {
  type    = string
  default = "2"      
}

# vm cpu
variable "trf_vm_worker_cores" {
  type    = string
  default = "2"      
}

# vm disc size
variable "trf_vm_worker_disc_size" {
  type    = string
  default = "10"      
}

# Yandex cloud vm image id 
# ("fd8j8m926pr7bbo0ckco" = Debian 10)
# ("fd8dmgc8d3slc0q9pjvv" = ubuntu 20.04)
# (fd8t5pejlu5ltqm4mvkv = CentOS Stream )
variable "trf_vm_worker_image_id" {
  type    = string
  default = "fd8dmgc8d3slc0q9pjvv"
}

# Yandex cloud NAT
variable "trf_vm_worker_nat" {
  type    = bool
  default = true      
}

# ipv6 
variable "trf_vm_worker_ipv6" {
  type    = bool
  default = false      
}
#=========================================


# VM Master
#=========================================
# Management ssh public key
variable "trf_mng_vm_master_public_key" {
   #type    = string
   default = ""
}

# Yandex cloud hardware platform 
# ( "standard-v3" = #Intel Ice Lake)
variable "trf_vm_master_platform_id" {
  type    = string
  default = "standard-v3"
}

# vm name
variable "trf_vm_master_name" {
  type    = string
  default = "master"      
}

# vm count
variable "trf_vm_master_count" {
  type    = string
  default = "1"      
}

# vm user
variable "trf_vm_master_user" {
  type    = string
  default = "admin"      
}

# vm memory 
variable "trf_vm_master_memory" {
  type    = string
  default = "2"      
}

# vm cpu
variable "trf_vm_master_cores" {
  type    = string
  default = "2"      
}

# vm disc size
variable "trf_vm_master_disc_size" {
  type    = string
  default = "10"      
}

# Yandex cloud vm image id 
# ("fd8j8m926pr7bbo0ckco" = Debian 10)
# ("fd8dmgc8d3slc0q9pjvv" = ubuntu 20.04)
# (fd8t5pejlu5ltqm4mvkv = CentOS Stream )
variable "trf_vm_master_image_id" {
  type    = string
  default = "fd8dmgc8d3slc0q9pjvv"
}

# Yandex cloud NAT
variable "trf_vm_master_nat" {
  type    = bool
  default = true      
}
# ipv6 
variable "trf_vm_master_ipv6" {
  type    = bool
  default = false      
}
#=========================================
