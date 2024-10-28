# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  backend "s3" {
    bucket = "lj5m0ov-s3-tfstate-bucket"
    key    = "hands-on/anw-vpc-full"
    region = "us-east-1"

  }
  required_version = "~> 1.7.0"
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Environment = "Learn"
      Service     = "AWS-Advanced Network Certification"
    }
  }
}

provider "local" {}
