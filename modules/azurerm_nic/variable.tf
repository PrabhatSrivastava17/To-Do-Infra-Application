variable "rg_name" {
  description = "The name of the resource group in which to create the network interface."
  type        = string
}
variable "location" {
  description = "The Azure region where the network interface will be created."
  type        = string
}