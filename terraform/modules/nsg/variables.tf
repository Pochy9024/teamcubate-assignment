variable "resource_group_name" {}
variable "location" {}
variable "nsg_name" {}

variable "bastion_subnet_address_prefix" {
  description = "The address prefix for the Bastion subnet."
  type        = string
  default     = "10.0.2.0/27"
}