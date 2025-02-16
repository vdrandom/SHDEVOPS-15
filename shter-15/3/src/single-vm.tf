resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.storage_vm.platform

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  resources {
    core_fraction = var.storage_vm.core_fraction
    cores         = var.storage_vm.cores
    memory        = var.storage_vm.memory
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.storage_vm.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage
    content {
      disk_id = secondary_disk.value.id
    }
  }
}

resource "yandex_compute_disk" "storage" {
  count = var.storage.count
  name  = "storage-${count.index + 1}"
  type  = var.storage.type
  size  = var.storage.size
}
