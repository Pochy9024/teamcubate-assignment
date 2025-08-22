resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-demo"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                      = "SSH-from-Bastion"
    priority                  = 100
    direction                 = "Inbound"
    access                    = "Allow"
    protocol                  = "Tcp"
    source_address_prefix      = var.bastion_subnet_address_prefix
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "80"
  }

  security_rule {
    name                        = "DenyAllOtherInbound"
    priority                    = 200
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "*"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "*"
  }
}