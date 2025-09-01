terraform {
  backend "azurerm" {
    resource_group_name   = "tcdemo-storage-state-rg"
    storage_account_name  = "tcdemotfstatesa"
    container_name        = "tfstate"
    key                   = "demo/vm.tfstate"
  }
}