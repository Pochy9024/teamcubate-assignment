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

variable "la_workspace_name" {
    type        = string
    description = "The name of the Log Analytics workspace."
}

variable "location" {
    type        = string
    description = "The location for the Log Analytics workspace."
    default     = "West Europe"
}

variable "monitor_rg_name" {
    type        = string
    description = "The name of the resource group for the monitoring resources."
}

variable "audit_monitor_name" {
    type        = string
    description = "The name of the audit monitor."
}

variable "target_resource_id" {
  type = string
  description = "The ID of the target resource for the diagnostic settings."
}