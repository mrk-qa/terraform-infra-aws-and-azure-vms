output "instance_types_aws" {
  value = random_shuffle.types_instance_aws.result[0]
}

output "instance_types_azure" {
  value = random_shuffle.types_instance_azure.result[0]
}

output "region_types_aws" {
  value = random_shuffle.types_region_aws.result[0]
}

output "region_types_azure" {
  value = random_shuffle.types_region_azure.result[0]
}

output "random_id" {
  value = random_id.server.hex
}

output "admin_username_azure" {
  value = random_pet.user.id
}