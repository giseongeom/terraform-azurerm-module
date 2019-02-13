variable "name" {
  description = "Name of the subnet to create"
}

variable "virtual_network_name" {}
variable "resource_group_name" {}

variable "address_prefix" {
  description = "The address prefix to use for the subnet."
}

variable "network_security_group_id" {
  description = "A Network Security Group ID to attach subnet"
  default     = ""
}

variable "route_table_id" {
  default = ""
}

variable "service_endpoints" {
  type    = "list"
  default = []
}
