# ********************************************************
#                        Outputs
# ********************************************************

output "vpc_id" {
  value       = aws_vpc.hands_on_VPC.id
  description = "VPC ID"
}

output "public-subnet-1-arn" {
  value       = aws_subnet.public_subnet_1.arn
  description = "Public Subnet 1 ARN"
}

output "public-subnet-2-arn" {
  value       = aws_subnet.public_subnet_2.arn
  description = "Public Subnet 2 ARN"
}

output "private-subnet-1-arn" {
  value       = aws_subnet.private_subnet_1.arn
  description = "Private Subnet 1 ARN"
}

output "igw" {
  value       = aws_internet_gateway.igw.id
  description = "Internet Gateway ID"
}

output "ngw" {
  value       = aws_nat_gateway.ngw.id
  description = "NAT Gateway ID"
}

output "mainRT" {
  value       = aws_route_table.mainRT.id
  description = "Main Route Table ID"
}