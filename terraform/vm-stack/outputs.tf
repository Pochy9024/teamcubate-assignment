# Virtual Machine outputs
output "vm_id" {
  description = "The ID of the virtual machine."
  value       = module.vm.vm_id
}

output "vm_private_ip" {
  description = "The private IP of the virtual machine."
  value       = module.vm.vm_public_ip
}

# Networking outputs
output "subnet_id" {
  description = "The ID of the subnet created for the VM."
  value       = module.networking.subnet_id
}

# NSG outputs
output "nsg_id" {
  description = "The ID of the network security group attached to the VM."
  value       = module.nsg.nsg_id
}