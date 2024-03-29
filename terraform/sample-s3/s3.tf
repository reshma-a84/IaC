# providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }

  backend "s3" {
    bucket = "30as7ln-s3-tfstate-bucket"
    key    = "hands-on/api-gateway"
    region = "ap-south-1"

  }
  required_version = "~> 1.5.0"
}

provider "aws" {
  region  = "ap-south-1"
  profile = "aws-terraform"

  default_tags {
    tags = {
      Environment = "Learn"
      Service     = "LearningService"
    }
  }
}


resource "random_string" "hands_on_random_string" {
  special = false
  upper   = false
  length  = 4
}

locals {
  prefix = "sample-${random_string.hands_on_random_string.result}"
}

resource "aws_s3_bucket" "hands_on_S3_Bucket" {
  bucket = "${local.prefix}-hands-on-bucket"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.hands_on_S3_Bucket.id
}