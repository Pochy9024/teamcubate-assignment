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
  default = "tcdemo-tfstate"
}

variable "vnet_name" {
  type    = string
  default = "storage-vnet-demo"
}

variable "subnet_name" {
  type    = string
  default = "storage-subnet-demo"
}

variable "whitelisted_ips" {
  type    = list(string)
  default = ["193.186.4.96", "178.148.189.147"]
}