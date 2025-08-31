# General
variable "location" {
  type    = string
  default = "East US"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

# Virtual Network
variable "vnet_name" {
  type    = string
  default = "vnet-demo"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "subnet-demo"
}

variable "subnet_address_space" {
  type    = string
  default = "10.0.1.0/24"
}

# Network Security Group
variable "nsg_name" {
  type    = string
  default = "nsg-demo"
}

# Virtual Machine
variable "vm_name" {
  type    = string
  default = "vm-demo"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type    = string
  default = "P@ssw0rd1234!"
}

variable "ssh_public_key" {
  type    = string
}