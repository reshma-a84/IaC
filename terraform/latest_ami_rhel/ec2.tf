data "aws_ami" "rhel" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["RHEL-9.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
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

resource "aws_instance" "rhel_instance" {
  ami           = data.aws_ami.rhel.id
  instance_type = "t2.micro"
}

output "rhel_name" {
  value = data.aws_ami.rhel.id
}

output "rhel_image_location" {
  value = data.aws_ami.rhel.image_location
}

output "rhel_description" {
  value = data.aws_ami.rhel.description
}

output "rhel_platform_details" {
  value = data.aws_ami.rhel.platform_details
}
output "rhel_public" {
  value = data.aws_ami.rhel.public
}

output "rhel_owner_id" {
  value = data.aws_ami.rhel.owner_id
}

output "rhel_state" {
  value = data.aws_ami.rhel.state
}

output "rhel_image_type" {
  value = data.aws_ami.rhel.image_type
}

output "rhel_image_owner_alias"{
  value = data.aws_ami.rhel.image_owner_alias
}