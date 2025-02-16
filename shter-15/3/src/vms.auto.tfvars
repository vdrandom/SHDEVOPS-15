web_vms = {
  platform      = "standard-v1"
  cores         = 2
  memory        = 1
  core_fraction = 5
  preemptible   = true
  nat           = true
}

db_vms = {
  main = {
    platform      = "standard-v1"
    cores         = 2
    memory        = 4
    core_fraction = 5
    disk_volume   = 20
    nat           = false
  }
  replica = {
    platform      = "standard-v1"
    cores         = 2
    memory        = 2
    core_fraction = 5
    disk_volume   = 10
    nat           = false
  }
}

storage_vm = {
  platform      = "standard-v1"
  cores         = 2
  memory        = 1
  core_fraction = 5
  preemptible   = true
  nat           = false
}

storage = {
  type  = "network-hdd"
  size  = 1
  count = 3
}
