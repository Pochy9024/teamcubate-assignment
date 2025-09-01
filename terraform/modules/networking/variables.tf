variable "location" {
  type        = string
  description = "Azure location for resources"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "tcdemo-networking-rg"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "networking-vnet-demo"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "storage_account_name" {
  type        = string
  description = "The name of the existing storage account."
  default     = "tcdemotfstatesa"
}

variable "storage_resource_group" {
  type        = string
  description = "The name of the resource group where the storage account is located."
  default     = "tcdemo-storage-state-rg"
}
