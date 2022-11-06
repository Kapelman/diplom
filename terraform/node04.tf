resource "yandex_compute_instance" "gitlab" {
  name                      = "gitlab"
  zone                      = "ru-central1-a"
  hostname                  = "gitlab.kapelman.online"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${yandex_compute_image.image-1.id}"
      name        = "gitlab"
      type        = "network-nvme"
      size        = "15"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet.id}"
    nat        = true
    ip_address = "192.168.101.15"
  }

  metadata = {
    ssh-keys = "vagrant:${file("~/.ssh/id_rsa.pub")}"
  }
}

# internal DNS record
resource "yandex_dns_recordset" "pris5" {
  zone_id = yandex_dns_zone.private-zone.id
  name    = "gitlab.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.gitlab.network_interface.0.ip_address]
}
