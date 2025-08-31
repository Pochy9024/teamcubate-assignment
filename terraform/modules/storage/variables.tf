variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
  default = "West Europe"
}

variable "storage_account_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "vnet_name" {
  type    = string
  default = "storage-vnet-demo"
}

variable "subnet_name" {
  type    = string
  default = "storage-subnet-demo"
}