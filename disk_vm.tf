resource "yandex_compute_disk" "storage_disk" {
  count     = 3
  name      = "storage-disk-${count.index}"
  size      = 1  
  type      = "network-hdd"
  zone      = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = var.vms_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vms_scheduling_policy.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.vms_metadata

  dynamic "secondary_disk" {
    for_each = { for i, d in yandex_compute_disk.storage_disk : i => d }

    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }
}