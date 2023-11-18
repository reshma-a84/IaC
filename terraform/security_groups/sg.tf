resource "aws_security_group" "hands_on_SG" {
  name        = "default_SSH"
  description = "Allow SSH Access"
  vpc_id      = aws_vpc.hands_on_VPC.id

  ingress {
    description = "Allow 22/SSH Access for VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hands_on_VPC.cidr_block]
  }
  ingress {
    description = "Allow 443/HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hands_on_VPC.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"    // -1 means "All Types" of traffic is allowed
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Learn Security Group"
  }
}

