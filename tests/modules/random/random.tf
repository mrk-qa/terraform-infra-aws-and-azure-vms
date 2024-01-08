resource "random_shuffle" "types_instance_aws" {
  input        = ["t2.nano", "t2.micro", "t2.small", "t2.medium"]
  result_count = 1
}

resource "random_shuffle" "types_instance_azure" {
  input        = ["Standard_B1ls2", "Standard_B1s", "Standard_B1ms", "Standard_B2s", "Standard_B2ms", "Standard_B4ms"]
  result_count = 1
}

resource "random_shuffle" "types_region_aws" {
  input        = ["ca-west-1", "ap-northeast-1", "eu-west-3", "ap-south-2", "us-east-1", "ap-southeast-3", "sa-east-1"]
  result_count = 1
}

resource "random_shuffle" "types_region_azure" {
  input        = ["BrazilSouth", "JapanEast", "FranceCentral", "WestIndia"]
  result_count = 1
}

resource "random_pet" "user" {
  prefix = "admin"
  length = 1
}

resource "random_id" "server" {
  byte_length = 8
}