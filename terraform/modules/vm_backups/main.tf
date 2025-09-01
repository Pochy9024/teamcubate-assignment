resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = var.vm_backup_policy_name
  resource_group_name = var.vm_backup_rg
  recovery_vault_name = var.vm_backup_recovery_vault_name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 7
  }
}

resource "azurerm_backup_protected_vm" "protected_vm" {
  resource_group_name = var.vm_backup_rg
  recovery_vault_name = var.vm_backup_recovery_vault_name
  source_vm_id        = var.vm_id
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy.id
}