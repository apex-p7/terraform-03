resource "yandex_vpc_network" "network" {    
  name = "netology"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.public_cidr]
}

resource "yandex_storage_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "image.jpg"
  source = "/home/master/terraform2/forest.jpg"
  acl    = "public-read"
}

resource "yandex_compute_instance_group" "group" {
  name               = "lamp-group"
  service_account_id = var.service_account_id
  
  allocation_policy {
    zones = [var.default_zone]
  }
  
  instance_template {
    platform_id = var.vms_platform_id

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.network.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      user-data = <<EOF
#cloud-config
write_files:
  - path: /var/www/html/index.html
    content: |
      <html>
      <body>
        <h1>Hello from Terraform!</h1>
        <img src="https://storage.yandexcloud.net/${var.bucket_name}/image.jpg" width="400">
      </body>
      </html>
EOF
    }
  }

  load_balancer {
    target_group_name = "lamp-target-group"
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }
}