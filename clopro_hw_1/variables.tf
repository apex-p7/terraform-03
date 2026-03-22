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

### network vars
variable "vpc_name" {
  type        = string
  default     = "netology"
  description = "VPC network&subnet name"
}

variable "public_cidr" {
  type        = string
  default     = "192.168.10.0/24"
}

variable "private_cidr" {
  type        = string
  default     = "192.168.20.0/24"
}

variable "nat_ip" {
  type        = string  
  default     = "192.168.10.254"
}

variable "nat_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_image_id" {
  type        = string  
  default     = "fd8kdq6d0p8sij7h5qe3"
}

variable "ssh_public_key_path" {
  type        = string  
  default     = "~/.ssh/id_rsa.pub"
}