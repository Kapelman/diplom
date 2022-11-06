resource "yandex_compute_instance" "nginx-node" {
  name                      = "nginx-node"
  zone                      = "ru-central1-a"
  hostname                  = "kapelman.online"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${yandex_compute_image.image-1.id}"
      name        = "nginx"
      type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet.id}"
    nat        = true
    ip_address = "192.168.101.11"
#    nat_ip_address = "178.154.225.125"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "yandex_dns_recordset" "pubs1" {
  zone_id = yandex_dns_zone.public-zone.id
  name    = "kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address]
}

resource "yandex_dns_recordset" "pubs2" {
  zone_id = yandex_dns_zone.public-zone.id
  name    = "alertmanager.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address]
}
resource "yandex_dns_recordset" "pubs3" {
  zone_id = yandex_dns_zone.public-zone.id
  name    = "prometheus.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address]
}
resource "yandex_dns_recordset" "pubs4" {
  zone_id = yandex_dns_zone.public-zone.id
  name    = "grafana.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address]
}
resource "yandex_dns_recordset" "pubs5" {
  zone_id = yandex_dns_zone.public-zone.id
  name    = "gitlab.kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address]
}


# internal DNS record
resource "yandex_dns_recordset" "pris1" {
  zone_id = yandex_dns_zone.private-zone.id
  name    = "kapelman.online."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.nginx-node.network_interface.0.ip_address]
}
