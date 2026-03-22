resource "yandex_vpc_network" "network" {    
  name = "netology"
}

resource "yandex_vpc_route_table" "rt" {
  name       = "private-route"
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_ip
  }
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.public_cidr]
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.private_cidr]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_compute_instance" "nat" {
  name = "nat-instance"
  zone = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = var.nat_ip
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "public_vm" {
  name = "public-vm"
  zone = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "private_vm" {
  name = "private-vm"
  zone = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

