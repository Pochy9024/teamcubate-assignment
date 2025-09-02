data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                         = var.kv_name
  resource_group_name          = var.kv_resource_group_name
  location                     = var.location
  enabled_for_disk_encryption  = true
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days   = 30
  purge_protection_enabled     = true

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "principal" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup",
      "Create",
      "Decrypt",
      "Delete",
      "Encrypt",
      "Get",
      "Import",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Sign",
      "UnwrapKey",
      "Update",
      "Verify",
      "WrapKey",
      "Release",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set"
    ]
}

resource "azurerm_role_assignment" "admin_role" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}