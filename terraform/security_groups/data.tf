data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "get_vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["Learn-VPC"]
  }
  depends_on = [aws_vpc.hands_on_VPC]
}