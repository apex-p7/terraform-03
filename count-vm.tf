resource "yandex_compute_instance" "web" {
  count = 2
  name = "web-${count.index + 1}"
  hostname = "web${count.index + 1}"
  platform_id = var.vms_platform_id
  depends_on = [yandex_compute_instance.db] # Зависимость от db ВМ
  zone = var.default_zone

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
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.vms_metadata

}