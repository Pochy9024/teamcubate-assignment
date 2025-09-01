provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "networking" {
  source               = "../modules/networking"
}

module "vm" {
  source              = "../modules/vm"
  bastion_subnet_address_prefix = module.networking.bastion_subnet_address_prefix
  vm_subnet_id = module.networking.vm_subnet_id
  ssh_public_key = var.ssh_public_key
  subscription_id = var.subscription_id

  depends_on = [ module.networking ]
}

module "bastion" {
  source               = "../modules/bastion"
  subnet_id            = module.networking.bastion_subnet_id

  depends_on           = [ module.networking ]
}

module "load_balancer" {
  source                = "../modules/load_balancer"
  resource_group_name   = module.networking.resource_group_name
  vm_nic_id             = module.vm.vm_nic_id
  vm_nic_ip_config_name = module.vm.vm_nic_ip_config_name

  depends_on = [ module.networking, module.vm ]
}

