variable "bastion_name" {
  description = "Name of the Azure Bastion Host"
  type        = string
  default     = "examplebastion"
}

variable "location" {
  description = "Azure region for the Bastion Host"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the Bastion Host"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Bastion Host"
  type        = string
}

variable "public_ip_address_id" {
  description = "Public IP address ID for the Bastion Host"
  type        = string
}