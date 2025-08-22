output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_public_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}