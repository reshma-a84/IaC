data "aws_ami" "amazon-linux-2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64*"]
  }
}

resource "aws_instance" "amzn2_linux_instance" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
}

output "amazon-linux-2_name" {
  value = data.aws_ami.amazon-linux-2.id
}

output "amazon-linux-2_image_location" {
  value = data.aws_ami.amazon-linux-2.image_location
}

output "amazon-linux-2_description" {
  value = data.aws_ami.amazon-linux-2.description
}

output "amazon-linux-2_platform_details" {
  value = data.aws_ami.amazon-linux-2.platform_details
}
output "amazon-linux-2_public" {
  value = data.aws_ami.amazon-linux-2.public
}

output "amazon-linux-2_owner_id" {
  value = data.aws_ami.amazon-linux-2.owner_id
}

output "amazon-linux-2_state" {
  value = data.aws_ami.amazon-linux-2.state
}

output "amazon-linux-2_image_type" {
  value = data.aws_ami.amazon-linux-2.image_type
}

output "amazon-linux-2_image_owner_alias"{
  value = data.aws_ami.amazon-linux-2.image_owner_alias
}