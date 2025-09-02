variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "kv_resource_group_name" {
  type        = string
  description = "The name of the Key Vault resource group."
  default     = "tcdemo-key-vault-rg"
}

variable "kv_name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "tcdemo-ansible-secrets-kv"
}