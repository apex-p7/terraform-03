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

variable "ssh_public_key_path" {
  type        = string  
  default     = "~/.ssh/id_rsa.pub"
}

variable "public_cidr" {
  type        = string
  default     = "192.168.10.0/24"
}

variable "bucket_name" {
  type        = string
  default     = "popov-2026-bucket-netology"
}

variable "service_account_id" {
  type        = string
  default     = "ajefroir42342nvolk3i"
}