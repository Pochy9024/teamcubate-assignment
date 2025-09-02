variable "vm_resource_group_name" {
  description = "Resource group name for the VM"
  type        = string
  default     = "tcdemo-vm-rg"
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "vtcdemo-vm"
}

variable "vm_nic_nsg_name" {
  description = "Network Security Group name for the VM NIC"
  type        = string
  default     = "tcdemo-vm-nic-nsg"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "West Europe"
}

variable "bastion_subnet_address_prefix" {
  description = "Address prefix for the Bastion subnet"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "vm_subnet_id" {
  description = "Subnet ID where the VM will be deployed"
  type        = string
}

variable "vm_nic_name" {
  description = "Name of the VM NIC"
  type        = string
  default     = "vtcdemo-vm-nic"
}

variable "la_workspace_name" {
    type        = string
    description = "The name of the Log Analytics workspace."
    default     = "tcdemo-vm-la-workspace"
}

variable "audit_monitor_name" {
    type        = string
    description = "The name of the audit monitor."
    default     = "tcdemo-vm-audit-monitor"
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "tcdemo-vm-key-vault"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "whitelisted_ips" {
  description = "List of IP addresses allowed to access the Key Vault"
  type        = list(string)
  default     = ["193.186.4.96", "178.148.189.147"]
}

