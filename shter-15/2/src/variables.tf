###cloud vars

# variable "cloud_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

# variable "folder_id" {
#   type        = string
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
# }

variable "vpc_name" {
  type        = string
  default     = "develop"
}

variable "subnets" {
  type = map(object({zone = string, cidr = list(string)}))
  default = {
    develop_a = {
      zone = "ru-central1-a"
      cidr = ["10.0.1.0/24"]
    }
    develop_b = {
      zone = "ru-central1-b"
      cidr = ["172.18.2.0/24"]
    }
  }
}

variable "environment" {
  type    = string
  default = "develop"
}

###metadata

variable "global_metadata" {
  type    = object({ssh-keys = string, serial-port-enable = number})
  default = {
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEt0hgwAMTEZNNQXn91s2dEj1R+jRR16qYQNZxZiAzD/"
    serial-port-enable = 1
  }
}
