resource "azurerm_key_vault_key" "kv_key" {
  name         = "tcdemo-vm-disk-encrypt-key"
  key_vault_id = var.vm_kv_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "wrapKey", "unwrapKey"]
}

resource "azurerm_disk_encryption_set" "main" {
  name                = var.vm_encryption_set_name
  location            = var.location
  resource_group_name = var.vm_resource_group_name
  key_vault_key_id    = azurerm_key_vault_key.kv_key.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "kv_role" {
  scope                = var.vm_kv_id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_disk_encryption_set.main.identity.0.principal_id
}