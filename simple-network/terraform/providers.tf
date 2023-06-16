terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.2"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      CreatedBy = "Samuel Slade"
    }
  }
}
