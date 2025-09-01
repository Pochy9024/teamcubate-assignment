provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = var.kv_resource_group_name
  location = var.location
}

module "ansible_kv" {
  source = "../modules/key_vault"

  subscription_id          = var.subscription_id
  kv_name                  = var.kv_name
  kv_resource_group_name   = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location

  depends_on = [ azurerm_resource_group.main ]
}