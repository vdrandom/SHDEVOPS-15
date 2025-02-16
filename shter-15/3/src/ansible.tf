resource "local_file" "ansible_inventory" {
  file_permission = "0644"
  filename        = "${path.module}/inventory.ini"
  content         = <<EOT
[webservers]
%{for host in yandex_compute_instance.web~}
${host.name} ansible_host=${host.network_interface.0.nat_ip_address != "" ? host.network_interface.0.nat_ip_address : host.network_interface.0.ip_address} fqdn=${host.fqdn}
%{endfor~}

[databases]
%{for name, host in yandex_compute_instance.db~}
${name} ansible_host=${host.network_interface.0.nat_ip_address != "" ? host.network_interface.0.nat_ip_address : host.network_interface.0.ip_address} fqdn=${host.fqdn}
%{endfor~}

[storage]
storage ansible_host=${yandex_compute_instance.storage.network_interface.0.nat_ip_address != "" ? yandex_compute_instance.storage.network_interface.0.nat_ip_address : yandex_compute_instance.storage.network_interface.0.ip_address} fqdn=${yandex_compute_instance.storage.fqdn}
EOT
}
