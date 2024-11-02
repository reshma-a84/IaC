# ********************************************************
#                        R53- Private Hosted zone
# ********************************************************
resource "aws_route53_zone" "private" {
  name = "anw.com"

  vpc {
    vpc_id = data.aws_vpc.get_vpc_id.id
  }
}

//add two a recors - one from public ec2 and one from private ec2  