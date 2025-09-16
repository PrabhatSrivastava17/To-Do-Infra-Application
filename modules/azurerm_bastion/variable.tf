variable "bastion_name" {
  description = "Name of the Azure Bastion Host"
  type        = string
}
variable "resource_group_name" {
  description = "Resource group name for the Bastion Host"
  type        = string
}
variable "location" {
  description = "The Azure region where the Bastion will be created."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Bastion Host"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP address to associate with the Bastion."
  type        = string
}

