# unit testing per resources

run "test_validation_key_pair_aws" {
  command = plan

  assert {
    condition     = aws_key_pair.key.key_name == "aws-key-github"
    error_message = "Key name did not match expected"
  }
}

run "test_validation_vm_aws" {
  command = plan

  assert {
    condition     = aws_instance.vm.ami == "ami-0c7217cdde317cfec"
    error_message = "AMI instance name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.instance_type == "t2.micro"
    error_message = "Instance type name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.subnet_id == data.terraform_remote_state.vpc.outputs.subnet_id_aws_full
    error_message = "Subnet IP did not match expected"
  }

  assert {
    condition     = aws_instance.vm.associate_public_ip_address == true
    error_message = "Associate public ip did not match expected"
  }

  assert {
    condition     = aws_instance.vm.user_data == "7fa4392f4d4793b8479890dc0fa291ffee7e1223"
    error_message = "User data did not match expected"
  }

  assert {
    condition     = aws_instance.vm.tags == tomap({ "Name" = "vm-terraform-github" })
    error_message = "Instance tags did not match expected"
  }
}

run "test_validation_public_ip_azure" {
  command = plan

  assert {
    condition     = azurerm_public_ip.public_ip.name == "public-ip-terraform-github"
    error_message = "Public IP name did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.allocation_method == "Dynamic"
    error_message = "Public IP method did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.location == "eastus"
    error_message = "Public IP location did not match expected"
  }

  assert {
    condition     = azurerm_public_ip.public_ip.tags == tomap({ owner = "marco-qa", managed-by = "terraform" })
    error_message = "Public IP tags did not match expected"
  }
}

run "test_validation_network_interface_azure" {
  command = plan

  assert {
    condition     = azurerm_network_interface.network_interface.name == "nic-tf-githu"
    error_message = "Network interface name did not match expected"
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
    condition     = azurerm_network_interface.network_interface.tags == tomap({ owner = "marco-qa", managed-by = "terraform" })
    error_message = "Network interface tags did not match expected"
  }
}

run "test_validation_association_interface_azure" {
  command = plan

  assert {
    condition     = azurerm_network_interface_security_group_association.association_interface.network_security_group_id == data.terraform_remote_state.vnet.outputs.security_group_id_azure_full
    error_message = "Association security group ID did not match expected"
  }
}

run "test_validation_vm_azure" {
  command = plan

  assert {
    condition     = azurerm_linux_virtual_machine.vm.name == "vm-terraform-github"
    error_message = "Virtual Machine name did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.resource_group_name == azurerm_resource_group.resource_group.name
    error_message = "Virtual Machine resource group did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.location == "eastus"
    error_message = "Virtual Machine location did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.size == "Standard_B1s"
    error_message = "Virtual Machine size did not match expected"
  }

  assert {
    condition     = azurerm_linux_virtual_machine.vm.admin_username == "terraform"
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
    condition     = azurerm_linux_virtual_machine.vm.tags == tomap({ owner = "marco-qa", managed-by = "terraform" })
    error_message = "Virtual Machine tags did not match expected"
  }
}