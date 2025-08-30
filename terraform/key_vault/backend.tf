terraform {
  backend "azurerm" {
    resource_group_name   = "rg-terraform-state"
    storage_account_name  = "tfstatestoragetc2025"
    container_name        = "tfstate"
    key                   = "demo/kv.tfstate"
  }
}