# ********************************************************
#                        VPC
# ********************************************************


resource "aws_vpc" "hands_on_VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ANW-VPC"
  }
}

