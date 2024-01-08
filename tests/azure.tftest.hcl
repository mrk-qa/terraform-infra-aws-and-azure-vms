# unit test per resources

run "loading_module_random" {
  module {
    source = "./tests/modules/random"
  }
}

run "{AZURE} test_validation_resource_group" {
  command = plan

  variables {
    rg_name_azure = "rg-vm-tf-github-${run.loading_module_random.random_id}"
    tag_id_azure = {
      owner      = "marco-${run.loading_module_random.random_id}"
      managed-by = "terraform-${run.loading_module_random.random_id}"
    }
    location_azure = run.loading_module_random.region_types_azure
  }

  assert {
    condition     = azurerm_resource_group.resource_group.name == "rg-vm-tf-github-${run.loading_module_random.random_id}"
    error_message = "Resource group name did not match expected"
  }

  assert {
    condition     = azurerm_resource_group.resource_group.location == lower(run.loading_module_random.region_types_azure)
    error_message = "Resource group location did not match expected"
  }

  assert {
    condition     = azurerm_resource_group.resource_group.tags == tomap({ owner = "marco-${run.loading_module_random.random_id}", managed-by = "terraform-${run.loading_module_random.random_id}" })
    error_message = "Resource group tags did not match expected"
  }
}

run "{AZURE} test_validation_public_ip" {
  command = plan

  variables {
    public_ip_name_azure = "public-ip-terraform-github-${run.loading_module_random.random_id}"
    tag_id_azure = {
      owner      = "marco-${run.loading_module_random.random_id}"
      managed-by = "terraform-${run.loading_module_random.random_id}"
    }
    location_azure = run.loading_module_random.region_types_azure
  }

  assert {
    condition     = azurerm_public_ip.public_ip.name == "public-ip-terraform-github-${run.loading_module_random.random_id}"
    error_message = "Public IP name did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.allocation_method == "Dynamic"
    error_message = "Public IP method did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.location == lower(run.loading_module_random.region_types_azure)
    error_message = "Public IP location did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.tags == tomap({ owner = "marco-${run.loading_module_random.random_id}", managed-by = "terraform-${run.loading_module_random.random_id}" })
    error_message = "Public IP tags did not match expected"
  }
}

run "{AZURE} test_validation_network_interface" {
  command = plan

  variables {
    network_interface_name_azure = "nic-tf-github-${run.loading_module_random.random_id}"
    ip_configuration_name_azure = "public-ip-terraform-github-${run.loading_module_random.random_id}"
    tag_id_azure = {
      owner      = "marco-${run.loading_module_random.random_id}"
      managed-by = "terraform-${run.loading_module_random.random_id}"
    }
    location_azure = run.loading_module_random.region_types_azure
  }

  assert {
    condition     = azurerm_network_interface.network_interface.name == "nic-tf-github-${run.loading_module_random.random_id}"
    error_message = "Network interface name did not match expected"
  }

  assert {
    condition     = azurerm_network_interface.network_interface.ip_configuration[0].name == "public-ip-terraform-github-${run.loading_module_random.random_id}"
    error_message = "IP configuration name did not match expected"
  }

  assert {
    condition     = azurerm_network_interface.network_interface.ip_configuration[0].subnet_id == data.terraform_remote_state.vnet.outputs.subnet_id_azure_full
    error_message = "Subnet ID did not match expected"
  }

  assert {
    condition     = azurerm_network_interface.network_interface.ip_configuration[0].private_ip_address_allocation == "Dynamic"
    error_message = "Private IP allocation did not match expected"
  }

  assert {
    condition     = azurerm_network_interface.network_interface.tags == tomap({ owner = "marco-${run.loading_module_random.random_id}", managed-by = "terraform-${run.loading_module_random.random_id}" })
    error_message = "Network interface tags did not match expected"
  }
}

run "{AZURE} test_validation_association_interface" {
  command = plan

  assert {
    condition     = azurerm_network_interface_security_group_association.association_interface.network_security_group_id == data.terraform_remote_state.vnet.outputs.security_group_id_azure_full
    error_message = "Association security group ID did not match expected"
  }
}

run "{AZURE} test_validation_vm" {
  command = plan

  variables {
    vm_name_azure = "vm-terraform-github-${run.loading_module_random.random_id}"
    vm_size_azure = run.loading_module_random.instance_types_azure
    vm_admin_username_azure = run.loading_module_random.admin_username_azure
    tag_id_azure = {
      owner      = "marco-${run.loading_module_random.random_id}"
      managed-by = "terraform-${run.loading_module_random.random_id}"
    }
    location_azure = run.loading_module_random.region_types_azure
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.name == "vm-terraform-github-${run.loading_module_random.random_id}"
    error_message = "Virtual Machine name did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.resource_group_name == azurerm_resource_group.resource_group.name
    error_message = "Virtual Machine resource group did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.location == lower(run.loading_module_random.region_types_azure)
    error_message = "Virtual Machine location did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.size == run.loading_module_random.instance_types_azure
    error_message = "Virtual Machine size did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.admin_username == run.loading_module_random.admin_username_azure
    error_message = "Virtual Machine admin_username did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.os_disk[0].caching == "ReadWrite"
    error_message = "Virtual Machine caching did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.os_disk[0].storage_account_type == "Standard_LRS"
    error_message = "Virtual Machine storage_account_type did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.source_image_reference[0].publisher == "Canonical"
    error_message = "Virtual Machine AMI publisher did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.source_image_reference[0].offer == "0001-com-ubuntu-server-jammy"
    error_message = "Virtual Machine AMI offer did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.source_image_reference[0].sku == "22_04-lts"
    error_message = "Virtual Machine AMI sku did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.source_image_reference[0].version == "latest"
    error_message = "Virtual Machine AMI version did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.tags == tomap({ owner = "marco-${run.loading_module_random.random_id}", managed-by = "terraform-${run.loading_module_random.random_id}" })
    error_message = "Virtual Machine tags did not match expected"
  }
}