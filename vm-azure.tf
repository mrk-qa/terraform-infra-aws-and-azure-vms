resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name_azure
  location = var.location_azure

  tags = local.common_tags
}

resource "azurerm_public_ip" "public_ip" {
  depends_on = [azurerm_resource_group.resource_group]

  name                = var.public_ip_name_azure
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location_azure
  allocation_method   = "Dynamic"

  tags = local.common_tags
}

resource "azurerm_network_interface" "network_interface" {
  depends_on = [azurerm_resource_group.resource_group]

  name                = var.network_interface_name_azure
  location            = var.location_azure
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = var.ip_configuration_name_azure
    subnet_id                     = data.terraform_remote_state.vnet.outputs.subnet_id_azure_full
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "association_interface" {
  depends_on = [azurerm_resource_group.resource_group]

  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = data.terraform_remote_state.vnet.outputs.security_group_id_azure_full
}

resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [
    azurerm_network_interface.network_interface,
    azurerm_public_ip.public_ip,
    azurerm_network_interface_security_group_association.association_interface
  ]

  name                = var.vm_name_azure
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location_azure
  size                = var.vm_size_azure
  admin_username      = var.vm_admin_username_azure
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  custom_data = var.environment == "test" ? base64encode(file("./scripts/index_hello_marco.sh")) : base64encode(file("./scripts/index_azure.sh"))

  admin_ssh_key {
    username   = var.vm_admin_username_azure
    public_key = var.azure_key_pub
  }

  os_disk {
    caching              = var.vm_os_disk_caching_azure
    storage_account_type = var.vm_os_disk_storage_azure
  }

  source_image_reference {
    publisher = var.vm_ami_publisher_azure
    offer     = var.vm_ami_offer_azure
    sku       = var.vm_ami_sku_azure
    version   = var.vm_ami_version_azure
  }

  tags = local.common_tags
}