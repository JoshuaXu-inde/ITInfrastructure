terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias   = "first"
  region  = var.region        //"ap-southeast-2"
  profile = var.profile_first //"indevin_network"
}

provider "aws" {
  alias   = "second"
  region  = var.region
  profile = var.profile_second
}