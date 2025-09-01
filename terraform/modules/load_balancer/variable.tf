
variable "lb_public_ip_name" {
  type        = string
  description = "The name of the public IP for the load balancer."
  default     = "tcdemo-lb-public-ip"
}

variable "lb_name" {
  type        = string
  description = "The name of the load balancer."
  default     = "tcdemo-load-balancer"
}

variable "lb_frontend_ip_name" {
  type        = string
  description = "The name of the frontend IP configuration for the load balancer."
  default     = "tcdemo-lb-frontend-ip"
}

variable "lb_backend_address_pool_name" {
  type        = string
  description = "The name of the backend address pool for the load balancer."
  default     = "tcdemo-lb-backend-pool"
}

variable "lb_http_probe_name" {
  type        = string
  description = "The name of the HTTP probe for the load balancer."
  default     = "tcdemo-lb-http-probe"
}

variable "location" {
  type        = string
  description = "The location where resources will be created."
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "vm_nic_id" {
  type        = string
  description = "The ID of the network interface to associate with the load balancer backend pool."
}

variable "vm_nic_ip_config_name" {
  type        = string
  description = "The name of the IP configuration for the network interface."
}