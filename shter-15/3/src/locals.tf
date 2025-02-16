locals {
  ssh_keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
}
