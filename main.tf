terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }

  backend "s3" {
    bucket = "remote-state-tf-marco-qa.amazonaws.com"
    key    = "pipeline-github/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "marco-qa"
      managed-by = "terraform"
    }
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "remote-state-tf-marco-qa.amazonaws.com"
    key    = "aws-vpc-full/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "remotestatetfmarcoqa"
    container_name       = "remote-state-container"
    key                  = "azure-vnet-full/terraform.tfstate"
  }
}