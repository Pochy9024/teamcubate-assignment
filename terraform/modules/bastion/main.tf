resource "azurerm_resource_group" "bastion_rg" {
  name     = var.bastion_resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  sku                 = var.bastion_sku
  tunneling_enabled    = true

  ip_configuration {
    name                 = var.bastion_ip_config_name
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

module "monitor_diagnostic" {
  source              = "../monitor_diagnostic"
  la_workspace_name   = var.la_workspace_name
  audit_monitor_name  = var.audit_monitor_name
  monitor_rg_name     = azurerm_resource_group.bastion_rg.name
  target_resource_id  = azurerm_bastion_host.bastion.id
}