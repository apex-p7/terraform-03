###cloud vars
variable "cloud_id" {
  type        = string
  default     = "b1gcjrlk0i1d3op3q77a"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1geh8jbc1scqn4i6uuh"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vms_platform_id" {
  type        = string
  default     = "standard-v2"
  }


variable "vms_scheduling_policy" {
  type = object({
    preemptible = bool
    })
  default = {
    preemptible = true
    }
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
    }
    
  }

variable "os_family" {
  type        = string
  default     = "ubuntu-2404-lts"
  description = "yandex_compute_image"
}

variable "vms_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAO7qdZdXTLa7pTCruSRgPltyFNrIveJrxoe9ZznmzPs master@krypt"
  }
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAO7qdZdXTLa7pTCruSRgPltyFNrIveJrxoe9ZznmzPs master@krypt"
  description = "ssh-keygen -t ed25519"
}

variable "each_vm" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = number
  }))
}