variable "vnet_name_prefix" {
  description = "VNet name prefix of the vnet to create"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = "map"
}
