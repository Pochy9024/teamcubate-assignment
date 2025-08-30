resource "azurerm_public_ip" "bastion_pip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  tunneling_enabled    = true

  ip_configuration {
    name                 = "bastion-ipconfig"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}