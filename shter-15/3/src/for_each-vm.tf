resource "yandex_compute_instance" "db" {
  for_each = var.db_vms

  name        = each.key
  platform_id = each.value["platform"]

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value["disk_volume"]
    }
  }

  resources {
    core_fraction = each.value["core_fraction"]
    cores         = each.value["cores"]
    memory        = each.value["memory"]
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value["nat"]
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }
}
