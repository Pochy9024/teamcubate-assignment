variable "vm_subnet_name" {
  type        = string
  description = "The name of the VM subnet."
  default     = "tcdemo-vm-subnet"
}

variable "bastion_subnet_name" {
  type        = string
  description = "The name of the Bastion subnet."
  default     = "AzureBastionSubnet"
}

variable "vm_subnet_address_space" {
  type        = list(string)
  description = "The address space for the VM subnet."
  default     = ["10.0.1.0/24"]
}

variable "bastion_subnet_address_space" {
  type        = list(string)
  description = "The address space for the Bastion subnet."
  default     = ["10.0.2.0/27"]
}

variable "vm_subnet_nsg_name" {
  type        = string
  description = "The name of the NSG for the VM subnet."
  default     = "tcdemo-vm-subnet-nsg"
}

variable "bastion_subnet_nsg_name" {
  type        = string
  description = "The name of the NSG for the Bastion subnet."
  default     = "tcdemo-bastion-subnet-nsg"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
  default     = "West Europe"
}