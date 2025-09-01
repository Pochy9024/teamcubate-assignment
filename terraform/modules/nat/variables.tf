variable "vm_nat_pip_name" {
  type        = string
  description = "The name of the public IP for the VM NAT gateway."
  default     = "tcdemo-vm-nat-pip"
}

variable "vm_nat_name" {
  type        = string
  description = "The name of the NAT gateway for the VM subnet."
  default     = "tcdemo-vm-nat-gw"
}

variable "location" {
  type        = string
  description = "Azure location for resources"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vm_subnet_id" {
  type        = string
  description = "The ID of the VM subnet to associate with the NAT gateway."
}
