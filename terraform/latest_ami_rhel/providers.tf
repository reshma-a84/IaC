# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  backend "s3" {
    bucket = "cert-ayzb-ho-tfstate-bucket"
    region = "us-east-1"
    key    = "tfstate/latest_ami"
  }
  required_version = "~> 1.6.0"
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
