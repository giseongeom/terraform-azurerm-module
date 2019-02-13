resource "random_string" "data_disk" {
  count   = "${var.num_data_disk}"
  length  = 32
  special = false
  upper   = false
}

resource "azurerm_managed_disk" "data_disk" {
  count                = "${var.enable_data_disk ? var.num_data_disk : 0}"
  name                 = "${var.datadisk_name_prefix}_${count.index}_DataDisk_${element(random_string.data_disk.*.result, count.index)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "${var.storage_account_type}"
  create_option        = "${var.create_option}"
  disk_size_gb         = "${var.disk_size_gb}"
  tags                 = "${var.tags}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  count              = "${var.enable_data_disk_attachment ? var.num_data_disk : 0}"
  managed_disk_id    = "${element(azurerm_managed_disk.data_disk.*.id,count.index)}"
  virtual_machine_id = "${var.virtual_machine_id}"
  lun                = "${var.lun_base + (count.index)}"
  caching            = "${var.caching}"
}
