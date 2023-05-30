terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
 required_version = ">= 0.13"
}

provider "yandex" {

  folder_id = var.trf_folder_id
  cloud_id  = var.trf_cloud_id
  token     = var.trf_token
  zone      = var.trf_zone_a
}