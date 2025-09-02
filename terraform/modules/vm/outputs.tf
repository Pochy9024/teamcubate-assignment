output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_nic_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_nic_ip_config_name" {
  value = azurerm_network_interface.nic.ip_configuration[0].name
}

output "vm_public_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}