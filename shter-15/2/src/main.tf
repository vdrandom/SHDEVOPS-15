resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnets" {
  for_each       = var.subnets
  name           = each.key
  zone           = each.value["zone"]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = each.value["cidr"]
}

data "yandex_compute_image" "ubuntu" {
  family = var.ubuntu_osfamily
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  zone        = var.subnets[var.vm_web_zone]["zone"]

  resources {
    cores         = var.vms_resources.web["cores"]
    memory        = var.vms_resources.web["memory"]
    core_fraction = var.vms_resources.web["core_fraction"]
  }

  scheduling_policy {
    preemptible = var.vms_resources.web["preemptible"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnets[var.vm_web_zone].id
    nat       = var.vm_web_nat
  }

  metadata = var.global_metadata
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.subnets[var.vm_db_zone]["zone"]

  resources {
    cores         = var.vms_resources.db["cores"]
    memory        = var.vms_resources.db["memory"]
    core_fraction = var.vms_resources.db["core_fraction"]
  }

  scheduling_policy {
    preemptible = var.vms_resources.db["preemptible"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnets[var.vm_db_zone].id
    nat       = var.vm_db_nat
  }

  metadata = var.global_metadata
}
