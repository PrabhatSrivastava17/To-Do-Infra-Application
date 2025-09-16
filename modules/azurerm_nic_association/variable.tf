variable "ip_configuration_name" {
  description = "The ID of the network interface to associate with the backend address pool."
  type        = string
}
variable "nic_name" {
  description = "The name of the network interface to associate with the backend address pool."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group in which the network interface is located."
  type        = string
}
variable "pool_name" {
  description = "The name of the backend address pool to associate with the network interface."
  type        = string
}
variable "lb_name" {
  description = "The name of the load balancer where the backend address pool is located."
  type        = string
}