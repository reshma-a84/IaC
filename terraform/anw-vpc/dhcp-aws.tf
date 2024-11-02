# ********************************************************
#                        DHCP
# ********************************************************

resource "aws_vpc_dhcp_options" "anw-dhcp" {
  domain_name         = "reshma.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    Name = "ANW-DHCP"
  }
}

# ********************************************************
#                      DHCP association
# ********************************************************

resource "aws_vpc_dhcp_options_association" "anw-dhcp-asso" {
  vpc_id          = data.aws_vpc.get_vpc_id.id
  dhcp_options_id = data.aws_vpc_dhcp_options.dhcp_option_id.id
  depends_on      = [aws_vpc_dhcp_options.anw-dhcp]
}