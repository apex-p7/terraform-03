resource "yandex_compute_instance" "db" {
  for_each = { for idx, vm in var.each_vm : vm.vm_name => vm }

  name = each.value.vm_name
  hostname = each.value.vm_name
  platform_id = var.vms_platform_id
  zone = var.default_zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
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
}