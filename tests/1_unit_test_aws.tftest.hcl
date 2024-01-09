# unit test per resources

run "loading_module_random_for_aws" {
  module {
    source = "./tests/modules/random"
  }
}

run "test_validation_key_pair_aws" {
  command = plan

  variables {
    key_pair_name_aws = "aws-key-github-${run.loading_module_random_for_aws.random_id}"
  }

  assert {
    condition     = aws_key_pair.key.key_name == "aws-key-github-${run.loading_module_random_for_aws.random_id}"
    error_message = "Key name did not match expected"
  }
}

run "test_validation_vm_aws" {
  command = plan

  variables {
    instance_type_aws = run.loading_module_random_for_aws.instance_types_aws
    key_pair_name_aws = "aws-key-github-${run.loading_module_random_for_aws.random_id}"
    tag_id_aws        = "vm-terraform-github-${run.loading_module_random_for_aws.random_id}"
  }

  assert {
    condition     = aws_instance.vm.ami == "ami-0c7217cdde317cfec"
    error_message = "AMI instance name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.key_name == "aws-key-github-${run.loading_module_random_for_aws.random_id}"
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
    condition     = aws_instance.vm.instance_type == run.loading_module_random_for_aws.instance_types_aws
    error_message = "Instance type name did not match expected"
  }

  assert {
    condition     = aws_instance.vm.associate_public_ip_address == true
    error_message = "Associate public ip did not match expected"
  }

  assert {
    condition     = length(aws_instance.vm.user_data) > 0
    error_message = "User data did not match expected"
  }

  assert {
    condition     = aws_instance.vm.tags == tomap({ "Name" = "vm-terraform-github-${run.loading_module_random_for_aws.random_id}" })
    error_message = "Instance tags did not match expected"
  }
}