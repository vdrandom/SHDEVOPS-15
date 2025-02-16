locals {
  vm_web_name = "netology-${var.environment}-${var.project}-${var.vm_web_role}"
  vm_db_name  = "netology-${var.environment}-${var.project}-${var.vm_db_role}"
}
