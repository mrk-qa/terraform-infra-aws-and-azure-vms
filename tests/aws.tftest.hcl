# unit test per resources

run "loading_module_random" {
  module {
    source = "./tests/modules/random"
  }
}

run "{AWS} test_validation_key_pair" {
  command = plan

  variables {
    key_pair_name_aws = "aws-key-github-${run.loading_module_random.random_id}"
  }

  assert {
    condition     = aws_key_pair.key.key_name == "aws-key-github-${run.loading_module_random.random_id}"
    error_message = "Key name did not match expected"
  }

  assert {
    condition     = can(regex("^(ssh-rsa AAAAB3NzaC1yc2|ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNT|ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzOD|ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1Mj|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5|ssh-dss AAAAB3NzaC1kc3)[0-9A-Za-z+/]+[=]{0,3}( .*)?$", aws_key_pair.key.public_key))
    error_message = "Public Key Regex did not match expected"
  }
}

run "test_validation_vm" {
  command = plan

  variables {
    instance_type_aws = run.loading_module_random.instance_types_aws
    key_pair_name_aws = "aws-key-github-${run.loading_module_random.random_id}"
    location_aws = run.loading_module_random.region_types_aws
    tag_id_aws = "vm-terraform-github-${run.loading_module_random.random_id}"
  }

  assert {
    condition     = aws_instance.vm.ami == "ami-0c7217cdde317cfec"
    error_message = "AMI instance name did not match expected"
  }

  assert {
    condition     = can(regex("^ami-[a-f0-9]{8,17}$", aws_instance.vm.ami))
    error_message = "AMI Regex did not match expected"
  }

  assert {
    condition     = aws_instance.vm.key_name == "aws-key-github-${run.loading_module_random.random_id}"
    error_message = "Key name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.subnet_id == data.terraform_remote_state.vpc.outputs.subnet_id_aws_full
    error_message = "Subnet IP did not match expected"
  }

  assert {
    condition     = can(regex("^subnet-[a-f0-9]{8,17}$", aws_instance.vm.subnet_id))
    error_message = "Subnet_id Regex did not match expected"
  }

  assert {
    condition     = can(regex("^sg-[a-f0-9]{8,17}$", data.terraform_remote_state.vpc.outputs.security_group_id_aws_full))
    error_message = "Security group Regex did not match expected"
  }

  assert {
    condition     = aws_instance.vm.instance_type == run.loading_module_random.instance_types_aws
    error_message = "Instance type name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.associate_public_ip_address == true
    error_message = "Associate public ip did not match expected"
  }

  assert {
    condition     = aws_instance.vm.user_data == "59a9e70bf24859606dddd2658015e11bf5aca697"
    error_message = "User data did not match expected"
  }

  assert {
    condition     = length(aws_instance.vm.user_data) > 0
    error_message = "User data did not match expected"
  }

  assert {
    condition     = aws_instance.vm.availability_zone == run.loading_module_random.region_types_aws
    error_message = "User data did not match expected"
  }

  assert {
    condition     = aws_instance.vm.tags == tomap({ "Name" = "vm-terraform-github-${run.loading_module_random.random_id}" })
    error_message = "Instance tags did not match expected"
  }
}