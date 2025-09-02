output "vm_subnet_id" {
  value = module.subnets.vm_subnet_id
}

output "bastion_subnet_id" {
  value = module.subnets.bastion_subnet_id
}

output "bastion_subnet_address_prefix" {
  value = module.subnets.bastion_subnet_address_prefix
}

output "resource_group_name" {
  value = azurerm_resource_group.networking.name
}