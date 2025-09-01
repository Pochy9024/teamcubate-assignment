resource "azurerm_recovery_services_vault" "backup_vault" {
  name                = "tcdemo-vm-backup-vault"
  location            = var.location
  resource_group_name = var.vm_backup_rg
  sku                 = "Standard"
  soft_delete_enabled = false
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = var.vm_backup_policy_name
  resource_group_name = var.vm_backup_rg
  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name

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
  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name
  source_vm_id        = var.vm_id
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy.id
}