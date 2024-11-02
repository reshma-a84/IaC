data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "get_vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["ANW-VPC"]
  }
  depends_on = [aws_vpc.hands_on_VPC]
}

# There will be many VPCs in the AWS account and how will you identify the one that you created?
# Use depends_on along with the RIGHT filter name and values. The name and value should match the one created with "tags" in the resource name, in this context the vpc

data "aws_vpc_dhcp_options" "dhcp_option_id" {
  filter {
    name   = "tag:Name"
    values = ["ANW-DHCP"]
  }
  depends_on = [aws_vpc_dhcp_options.anw-dhcp]
}

data "aws_security_group" "ssh" {
  filter {
    name   = "tag:Name"
    values = ["ssh-sg"]
  }
  depends_on = [aws_vpc.hands_on_VPC]

}

data "aws_security_group" "icmp" {
  filter {
    name   = "tag:Name"
    values = ["icmp"]
  }
  depends_on = [aws_vpc.hands_on_VPC]

}
data "external" "my_ip" {
  program = ["bash", "${path.module}/my-ip.sh"]
}
