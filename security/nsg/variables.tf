# Network Security Group definition
variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {}
variable "nsg_rule_base_priority" {}

variable "security_group_name_prefix" {
  description = "Network security group name prefix"
}

variable "tags" {
  description = "The tags to associate with your network security group."
  type        = "map"
  default     = {}
}

# Security Rules definition 

# Custom security rules
# [priority, direction, access, protocol, source_port_range, destination_port_range, description]"
# All the fields are required.
variable "custom_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = "list"
  default     = []
}

## source address prefix to be applied to all rules
#variable "source_address_prefix" {
#  type    = "list"
#  default = ["*"]
#
#  # Example ["10.0.3.0/24"] or ["VirtualNetwork"]
#}
#
## Destination address prefix to be applied to all rules
#variable "destination_address_prefix" {
#  type    = "list"
#  default = ["*"]
#
#  # Example ["10.0.3.0/32","10.0.3.128/32"] or ["VirtualNetwork"] 
#}
