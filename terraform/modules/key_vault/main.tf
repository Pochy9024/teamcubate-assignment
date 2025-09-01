data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                         = var.kv_name
  resource_group_name          = var.kv_resource_group_name
  location                     = var.location
  enabled_for_disk_encryption  = true
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days   = 30
  purge_protection_enabled     = true

  public_network_access_enabled = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"

    ip_rules = var.whitelisted_ips
  }
}