# ********************************************************
#               Security Group -  Default 
# ********************************************************

resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.get_vpc_id.id
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "default"
  }
}

# ********************************************************
#                     Security Group
# ********************************************************

resource "aws_security_group" "sg-ssh" {
  vpc_id = data.aws_vpc.get_vpc_id.id
  name   = "new"
  tags = {
    Name = "new"
  }
}


# ********************************************************
#           Security Group - Ingress Rules
# ********************************************************
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  ip_protocol       = "tcp"
  to_port           = 22
  from_port         = 22
  cidr_ipv4         = "${data.external.my_ip.result["ip"]}/32"
  security_group_id = aws_security_group.sg-ssh.id
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  ip_protocol       = "icmp"
  to_port           = -1
  from_port         = -1
  cidr_ipv4         = aws_vpc.hands_on_VPC.cidr_block
  security_group_id = aws_security_group.sg-ssh.id
}


# ********************************************************
#           Security Group - Egress Rules
# ********************************************************

resource "aws_vpc_security_group_egress_rule" "ssh" {
  ip_protocol       = -1
  cidr_ipv4         = aws_vpc.hands_on_VPC.cidr_block
  security_group_id = aws_security_group.sg-ssh.id
}