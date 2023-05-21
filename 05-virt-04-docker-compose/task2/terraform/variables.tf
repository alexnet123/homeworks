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
  default = "test-net2"      
}

# Subnet web_net_subnet_a
#------------------------------------------
# CIDR
variable "trf_web_net_subnet_test_net2_a_cidrs" {
  type = list(string)
  default = ["192.168.12.0/24"]
}

# Name
variable "trf_web_net_subnet_test_net2_a_name" {
  type = string
  default = "test-net2-a"
}
#------------------------------------------


#=========================================

# VM node01
#=========================================
# Management ssh public key
variable "trf_mng_node01_public_key" {
   #type    = string
   default = ""
}

# Yandex cloud hardware platform 
# ( "standard-v3" = #Intel Ice Lake)
variable "trf_node01_platform_id" {
  type    = string
  default = "standard-v3"
}

# vm name
variable "trf_node01_name" {
  type    = string
  default = "node01"      
}

# vm count
variable "trf_node01_count" {
  type    = string
  default = "1"      
}

# vm user
variable "trf_node01_user" {
  type    = string
  default = "admin"      
}

# vm memory 
variable "trf_node01_memory" {
  type    = string
  default = "2"      
}

# vm cpu
variable "trf_node01_cores" {
  type    = string
  default = "2"      
}

# vm disc size
variable "trf_node01_disc_size" {
  type    = string
  default = "10"      
}

# Yandex cloud vm image id 
# ("fd8j8m926pr7bbo0ckco" = Debian 10)
# (fd8t5pejlu5ltqm4mvkv = CentOS Stream )
# (fd86011gghoc98v0cdvs = CentOS 8 Stream + python)
variable "trf_node01_image_id" {
  type    = string
  default = "fd86011gghoc98v0cdvs"
}

# Yandex cloud NAT
variable "trf_node01_nat" {
  type    = bool
  default = true      
}
# ipv6 
variable "trf_node01_ipv6" {
  type    = bool
  default = false      
}
#=========================================


# VM node02
#=========================================
# Management ssh public key
variable "trf_mng_node02_public_key" {
   #type    = string
   default = ""
}

# Yandex cloud hardware platform 
# ( "standard-v3" = #Intel Ice Lake)
variable "trf_node02_platform_id" {
  type    = string
  default = "standard-v3"
}

# vm name
variable "trf_node02_name" {
  type    = string
  default = "node02"      
}

# vm count
variable "trf_node02_count" {
  type    = string
  default = "1"      
}

# vm user
variable "trf_node02_user" {
  type    = string
  default = "admin"      
}

# vm memory 
variable "trf_node02_memory" {
  type    = string
  default = "2"      
}

# vm cpu
variable "trf_node02_cores" {
  type    = string
  default = "2"      
}

# vm disc size
variable "trf_node02_disc_size" {
  type    = string
  default = "10"      
}

# Yandex cloud vm image id 
# ("fd8j8m926pr7bbo0ckco" = Debian 10)
# (fd8t5pejlu5ltqm4mvkv = CentOS Stream )
# (fd86011gghoc98v0cdvs = CentOS 8 Stream + python)
variable "trf_node02_image_id" {
  type    = string
  default = "fd86011gghoc98v0cdvs"
}

# Yandex cloud NAT
variable "trf_node02_nat" {
  type    = bool
  default = true      
}
# ipv6 
variable "trf_node02_ipv6" {
  type    = bool
  default = false      
}
#=========================================
