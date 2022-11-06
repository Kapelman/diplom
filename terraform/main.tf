#bucket
terraform {

# required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
# }

backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "kapelmanbucket2"
    region     = "ru-central1"
    key        = "state/terraform.tfstate"
    access_key = "############################################"
    secret_key = "###############################################"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

}

#provider "yandex" {
#  token                    = ""
#  cloud_id                 = ""
#  folder_id                = ""
#  zone                     = "ru-central1-a"
#}
