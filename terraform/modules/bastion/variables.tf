variable "bastion_resource_group_name" {
    type        = string
    description = "The name of the resource group for the Bastion host."
    default     = "tcdemo-bastion-rg"
}

variable "location" {
    type        = string
    description = "The location for the Bastion host."
    default     = "West Europe"
}
variable "subnet_id" {
    type        = string
    description = "The ID of the subnet for the Bastion host."
}
variable "public_ip_name" {
    type        = string    
    description = "The name of the public IP for the Bastion host."
    default     = "tcdemo-bastion-pip"
}

variable "bastion_name" {
    type        = string
    description = "The name of the Bastion host."
    default     = "tcdemo-bastion-host"
}

variable "bastion_ip_config_name" {
    type        = string
    description = "The name of the Bastion host IP configuration."
    default     = "tcdemo-bastion-ipconfig"
}

variable "bastion_sku" {
    type        = string
    description = "The SKU of the Bastion host."
    default     = "Standard"
}

variable "la_workspace_name" {
    type        = string
    description = "The name of the Log Analytics workspace."
    default     = "tcdemo-bastion-la-workspace"
}

variable "audit_monitor_name" {
    type        = string
    description = "The name of the audit monitor."
    default     = "tcdemo-bastion-audit-monitor"
}
