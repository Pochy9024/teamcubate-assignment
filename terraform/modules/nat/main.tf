resource "azurerm_public_ip" "nat_gw_ip" {
  name                = var.vm_nat_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "vm_nat_gw" {
  name                = var.vm_nat_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "vm_nat_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.vm_nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "vm_nat_assoc" {
  subnet_id      = var.vm_subnet_id
  nat_gateway_id = azurerm_nat_gateway.vm_nat_gw.id
}