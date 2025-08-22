variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "subnet_name" {}
variable "subnet_address_space" {}

variable "bastion_subnet_name" {
  description = "The name of the Azure Bastion subnet."
  type        = string
  default     = "AzureBastionSubnet"
}

variable "bastion_subnet_address_space" {
  description = "The address space for the Azure Bastion subnet."
  type        = string
  default     = "10.0.2.0/27"
}