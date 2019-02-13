variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {}

variable "enable_data_disk" {
  default = true
}

variable "enable_data_disk_attachment" {
  default = true
}

variable "num_data_disk" {
  default = 0
}

variable "lun_base" {
  default = 0
}

variable "caching" {
  default = "ReadOnly"
}

variable "datadisk_name_prefix" {
  default = "myvm"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "virtual_machine_id" {}

variable "create_option" {
  default = "Empty"
}

variable "disk_size_gb" {
  default = "myvm"
}

variable "tags" {
  description = "The tags to associate with your network security group."
  type        = "map"
  default     = {}
}
