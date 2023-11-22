data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  
  filter {
      name   = "name"
      values = ["*centos7*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }

}

resource "aws_instance" "centos_instance" {
  ami           = data.aws_ami.centos.id
  instance_type = "t2.micro"
}

