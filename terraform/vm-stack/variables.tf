# General

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
# Virtual Machine
variable "vm_name" {
  type    = string
  default = "vm-demo"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type    = string
  default = "P@ssw0rd1234!"
}

variable "ssh_public_key" {
  type    = string
}