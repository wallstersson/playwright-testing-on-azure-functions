variable "resource_group_location" {
  default     = "swedencentral"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default = "rg-playwright-availability-tester"
  description = "Name of the resource group."
}

variable "name" {
  default     = "availabilitytester"
  description = "Prefix for the resource names."
}