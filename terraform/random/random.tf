# ****************************************************************
#                    Providers
# ****************************************************************

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  profile                  = "aws-terraform"
  shared_credentials_files = ["/Users/reshu/.aws/credentials"]
  shared_config_files      = ["/Users/reshu/.aws/config"]
}

# ****************************************************************
#                    Random Generation
# ****************************************************************

# resource "random_string" "name" {
#   special = false
#   upper   = false
#   length  = 7
# }

# locals {
#   prefix = "random-${random_string.name.result}"
# }

resource "random_pet" "name" {
  length  = 2
}

locals {
  prefix = "random-${random_pet.name.id}"
}

# ****************************************************************
#                    S3 Bucket
# ****************************************************************

resource "aws_s3_bucket" "demo-s3" {
  bucket = "${local.prefix}-s3"
}

# ****************************************************************
#                    Lambda functions
# ****************************************************************

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "lambda"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${local.prefix}-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.9"
  timeout          = 900
}

# ****************************************************************
#                    IAM Role - Lambda
# ****************************************************************

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "${local.prefix}-iam-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# ****************************************************************
#                    Output
# ****************************************************************

# output "s3_bucket" {
#   value = aws_s3_bucket.demo-s3.bucket
# }

output "pet_name" {
  value = local.prefix
}