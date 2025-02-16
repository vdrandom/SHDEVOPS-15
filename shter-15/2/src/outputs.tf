locals {
  vms = [
      yandex_compute_instance.platform,
      yandex_compute_instance.platform_db,
  ]
}

output "vms" {
  value = [
    for vm in local.vms : {
      instance_name = vm.name
      external_ip = vm.network_interface.0.nat_ip_address
      fqdn = vm.fqdn
    }
  ]
}
