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


variable "ami_filter" {
  description = "Filter criteria for AMI lookup"
  type        = map(string)
  default     = {
    name         = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    virtualization_type = "hvm"
    most_recent = true
  }
}

data "aws_ami" "selected_ami" {
  most_recent = var.ami_filter["most_recent"]
  
  filter {
    name   = "name"
    values = [var.ami_filter["name"]]
  }
  
  filter {
    name   = "virtualization-type"
    values = [var.ami_filter["virtualization_type"]]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.selected_ami.id
  instance_type = "t2.micro"  # Change this to your desired instance type
}

output "selected_ami_id" {
  value = data.aws_ami.selected_ami.id
}
