resource "yandex_compute_instance" "runner" {
  name                      = "runner"
  zone                      = "ru-central1-a"
  hostname                  = "runner.kapelman.online"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${yandex_compute_image.image-1.id}"
      name        = "runner"
      type        = "network-nvme"
      size        = "15"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet.id}"
    nat        = true
    ip_address = "192.168.101.16"
  }

  metadata = {
    ssh-keys = "vagrant:${file("~/.ssh/id_rsa.pub")}"
  }
}

# internal DNS record
resource "yandex_dns_recordset" "pris6" {
  zone_id = yandex_dns_zone.private-zone.id
  name    = "runner.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.runner.network_interface.0.ip_address]
}
