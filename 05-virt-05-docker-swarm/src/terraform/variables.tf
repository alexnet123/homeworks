# Заменить на ID своего облака
variable "trf_cloud_id" {
  type    = string
  default = ""
}

# Заменить на Folder своего облака
variable "trf_folder_id" {
  type    = string
  default = ""
}


# Заменить на trf_token своего облака
variable "trf_token" {
  type    = string
  default = ""
}

# Yandex cloud region
variable "trf_zone_a" {
  type    = string
  default = "ru-central1-a" 
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  type    = string
  default = "fd86d6gsflclmp9htila"
}
