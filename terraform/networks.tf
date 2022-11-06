# Network
resource "yandex_vpc_network" "net" {
  name = "kapelman-net"
}

resource "yandex_vpc_subnet" "subnet" {
  name = "kapleman-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.net.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}

#Public DNS zone

resource "yandex_dns_zone" "public-zone" {
  name        = "my-public-zone"
  description = "Kapelman`s public zone"

  labels = {
    label1 = "kapelman-public"
  }

  zone    = "kapelman.online."
  public  = true
}


# Private DNS zone

resource "yandex_dns_zone" "private-zone" {
  name        = "my-private-zone"
  description = "Kapelman`s private zone"

  labels = {
    label1 = "label-1-value"
  }

  zone             = "kapelman.online."
  public           = false
  private_networks = [yandex_vpc_network.net.id]
}
