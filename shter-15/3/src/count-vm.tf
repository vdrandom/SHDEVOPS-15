resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"
  platform_id = var.web_vms.platform

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  resources {
    core_fraction = var.web_vms.core_fraction
    cores         = var.web_vms.cores
    memory        = var.web_vms.memory
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.web_vms.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = local.ssh_keys
  }

  depends_on = [yandex_compute_instance.db]
}
