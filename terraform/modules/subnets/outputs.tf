output "vm_subnet_id" {
  value = azurerm_subnet.vm_subnet.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "bastion_subnet_address_prefix" {
  value = azurerm_subnet.bastion_subnet.address_prefixes[0]
}
