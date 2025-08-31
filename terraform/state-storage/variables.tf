variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group."
}

variable "location" {
  type = string
  description = "The location where resources will be created."
}

variable "storage_account_name" {
  type = string
  description = "The name of the storage account."
  default = "tcdemotfstatesa"
}

variable "container_name" {
  type = string
  description = "The name of the container within the storage account."
  default = "tfstate"
}