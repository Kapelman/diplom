#bucket to create
terraform {

 required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
 
 }

}

provider "yandex" {
  token                    = "####################################"
  cloud_id                 = "b1g0k29qecug0jk3jt4i"
  folder_id                = "b1g5fh031uiok7frafp8"
  zone                     = "ru-central1-a"
}

resource "yandex_storage_bucket" "state-bucket" {
    access_key = "##########################"
    secret_key = "#################################"
    bucket     = "kapelmanbucket2"
  }
