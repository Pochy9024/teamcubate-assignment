variable "vm_kv_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "vm_encryption_set_name" {
  description = "Name of the VM disk encryption set"
  type        = string
  default     = "tcdemo-vm-disk-encryption-set"
}

variable "vm_resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "West Europe"
}