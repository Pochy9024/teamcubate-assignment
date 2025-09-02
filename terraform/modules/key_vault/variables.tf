variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "kv_resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "West Europe"
}

variable "whitelisted_ips" {
  description = "List of IP addresses allowed to access the Key Vault"
  type        = list(string)
  default     = []
}