locals {
  web_vms = [
    for vm in yandex_compute_instance.web :
    {
      name      = vm.name
      public_ip = vm.network_interface[0].nat_ip_address
      fqdn      = vm.fqdn
    }
  ]

  db_vms = [
    for vm in values(yandex_compute_instance.db) :
    {
      name      = vm.name
      public_ip = vm.network_interface[0].nat_ip_address
      fqdn      = vm.fqdn
    }
  ]

  storage_vms = [
    {
      name      = yandex_compute_instance.storage.name
      public_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn      = yandex_compute_instance.storage.fqdn
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("${path.module}/inventory.tpl", {
    web_vms     = local.web_vms
    db_vms      = local.db_vms
    storage_vms = local.storage_vms
  })
  filename = "${path.module}/inventory.ini"
}
