variable "vm_backup_policy_name" {
  description = "The name of the VM backup policy."
  type        = string
  default     = "vm-backup-policy"
}

variable "vm_backup_rg" {
  description = "The name of the resource group for VM backups."
  type        = string
}

variable "vm_backup_recovery_vault_name" {
  description = "The name of the recovery vault for VM backups."
  type        = string
}

variable "vm_id" {
  description = "The ID of the virtual machine to be backed up."
  type        = string
}