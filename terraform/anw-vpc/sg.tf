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
#             Public Security Group
# ********************************************************

resource "aws_security_group" "anw-sg-ssh" {
  name   = "ssh-sg"
  vpc_id = data.aws_vpc.get_vpc_id.id
  tags = {
    Name = "ssh-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = data.aws_security_group.ssh.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "${data.external.my_ip.result["ip"]}/32"
}

resource "aws_vpc_security_group_egress_rule" "allow-all-traffic" {
  security_group_id = data.aws_security_group.ssh.id
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "anw-sg-icmp" {
  name   = "icmp"
  vpc_id = data.aws_vpc.get_vpc_id.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-icmp" {
  security_group_id = data.aws_security_group.icmp.id
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_ipv4         = aws_subnet.public_subnet_1.cidr_block
}
