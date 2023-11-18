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
#              Subnets - 2 Public & 1 Private 
# ********************************************************

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = data.aws_vpc.get_vpc_id.id
  availability_zone       = "ap-south-1a"
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "Learn-Public-Subnet-1"
  }

  depends_on = [aws_vpc.hands_on_VPC]
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = data.aws_vpc.get_vpc_id.id
  availability_zone       = "ap-south-1b"
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  tags = {
    Name = "Learn-Public-Subnet-2"
  }

  depends_on = [aws_vpc.hands_on_VPC]
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = data.aws_vpc.get_vpc_id.id
  availability_zone       = "ap-south-1c"
  cidr_block              = "10.0.32.0/20"
  map_public_ip_on_launch = false
  tags = {
    Name = "Learn-Private-Subnet-1"
  }

  depends_on = [aws_vpc.hands_on_VPC]
}

# ********************************************************
#                   Internet Gateway
# ********************************************************

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.get_vpc_id.id

  tags = {
    Name = "Learn-IGW"
  }

  depends_on = [aws_vpc.hands_on_VPC]

}

# ********************************************************
#                   NAT Gateway
# ********************************************************
resource "aws_eip" "elasticIP_NAT_gateway" {

}

resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.elasticIP_NAT_gateway.id
  subnet_id         = aws_subnet.public_subnet_1.id
  connectivity_type = "public"


  tags = {
    Name = "Learn-NGW"
  }

  depends_on = [aws_subnet.public_subnet_1]

}

# ********************************************************
#                   Route Tables
# ********************************************************

resource "aws_route_table" "mainRT" {
  vpc_id = data.aws_vpc.get_vpc_id.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Learn-RT"
  }
}

resource "aws_main_route_table_association" "mainRT_association" {
  vpc_id         = data.aws_vpc.get_vpc_id.id
  route_table_id = aws_route_table.mainRT.id

}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.mainRT.id

  depends_on = [aws_subnet.public_subnet_1, aws_route_table.mainRT]
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.mainRT.id

  depends_on = [aws_subnet.public_subnet_2, aws_route_table.mainRT]
}