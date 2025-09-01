# Create the resource group
resource "azurerm_resource_group" "networking" {
  name     = var.resource_group_name
  location = var.location
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name

  depends_on = [ azurerm_resource_group.networking ]
}

# Create VM and Bastion Subnets with NSGs
module "subnets" {
  source              = "../subnets"
  resource_group_name = azurerm_resource_group.networking.name
  vnet_name           = azurerm_virtual_network.vnet.name
  location            = azurerm_resource_group.networking.location

  depends_on = [ azurerm_virtual_network.vnet ]
}

# Create the VM Subnet NAT Gateway
module "nat_gateway" {
  source              = "../nat"
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
  vm_subnet_id        = module.subnets.vm_subnet_id
}

# Create Subnets Flow Logs
module "subnets_flow_logs" {
  source                 = "../subnet_flow_logs"
  resource_group_name    = azurerm_resource_group.networking.name
  location               = azurerm_resource_group.networking.location
  vm_subnet_id           = module.subnets.vm_subnet_id
  bastion_subnet_id      = module.subnets.bastion_subnet_id
  storage_account_name   = var.storage_account_name
  storage_resource_group = var.storage_resource_group
}

