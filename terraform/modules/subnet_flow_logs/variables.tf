variable "network_watcher_name" {
  type        = string
  description = "The name of the network watcher."
  default     = "NetworkWatcher_westeurope"
}

variable "network_watcher_rg" {
  type        = string
  description = "The resource group of the network watcher."
  default     = "NetworkWatcherRG"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the existing storage account to store flow logs."
}

variable "storage_resource_group" {
  type        = string
  description = "The resource group of the existing storage account."
}

variable "la_workspace_name" {
  type        = string
  description = "The name of the Log Analytics workspace."
  default     = "tcdemo-la-workspace"
}

variable "location" {
  type        = string
  description = "Azure location for resources"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vm_subnet_id" {
  type        = string
  description = "The ID of the subnet to enable flow logs on."
}

variable "bastion_subnet_id" {
  type        = string
  description = "The ID of the bastion subnet to enable flow logs on."
}

variable "vm_flow_logs_name" {
  type        = string
  description = "The name of the flow logs for the VM subnet."
  default     = "tcdemo-vm-flow-logs"
}

variable "bastion_flow_logs_name" {
  type        = string
  description = "The name of the flow logs for the Bastion subnet."
  default     = "tcdemo-bastion-flow-logs"
}