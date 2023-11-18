# ********************************************************
#                        VPC
# ********************************************************


resource "aws_vpc" "hands_on_VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Learn-VPC"
  }
}

# ********************************************************
#              Subnets - 2 Public 
# ********************************************************

resource "aws_subnet" "public_subnet_1" {
  count                   = 2
  vpc_id                  = data.aws_vpc.get_vpc_id.id
  availability_zone       = var.public_subnet_az[count.index]
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Learn-Public-Subnet-${count.index + 1}"
  }

  depends_on = [aws_vpc.hands_on_VPC]
}

