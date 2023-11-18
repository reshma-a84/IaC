# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  backend "s3" {
    bucket = "30as7ln-s3-tfstate-bucket"
    key    = "hands-on/ec2-full"
    region = "ap-south-1"

  }
  required_version = "~> 1.5.0"
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Environment = "Learn"
      Service     = "LearningService"
    }
  }
}
