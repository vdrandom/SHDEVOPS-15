
variable "ubuntu_osfamily" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "project" {
  type    = string
  default = "platform"
}

### web
# variable "vm_web_name" {
#   type    = string
#   default = "netology-develop-platform-web"
# }
variable "vm_web_role" {
  type    = string
  default = "web"
}
variable "vm_web_zone" {
  type    = string
  default = "develop_a"
}
variable "vm_web_platform_id" {
  type    = string
  default = "standard-v1"
}
variable "vm_web_nat" {
  type    = bool
  default = true
}

### db
# variable "vm_db_name" {
#   type    = string
#   default = "netology-develop-platform-db"
# }
variable "vm_db_role" {
  type    = string
  default = "db"
}
variable "vm_db_zone" {
  type    = string
  default = "develop_b"
}
variable "vm_db_platform_id" {
  type    = string
  default = "standard-v1"
}
variable "vm_db_nat" {
  type    = bool
  default = true
}

variable "vms_resources" {
  type = map(object({cores = number, memory = number, core_fraction = number, preemptible = bool}))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      preemptible   = true
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      preemptible   = true
    }
  }
}
