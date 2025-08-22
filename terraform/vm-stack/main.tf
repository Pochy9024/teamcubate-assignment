provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "networking" {
  source               = "../modules/networking"
  resource_group_name  = var.resource_group_name
  location             = var.location
  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  subnet_name          = var.subnet_name
  subnet_address_space = var.subnet_address_space
}

module "nsg" {
  source              = "../modules/nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  nsg_name            = var.nsg_name
}

module "vm" {
  source              = "../modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  subnet_id           = module.networking.subnet_id
  nsg_id              = module.nsg.nsg_id
  ssh_public_key      = var.ssh_public_key
}