variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = null
}

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "kv_name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "ansible-kv-demo"
}