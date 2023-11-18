variable "region" {
  description = "provides details about a specific AWS region"
  default     = "ap-south-1"

}

variable "profile" {
  description = "AWS CLI profile information"
  default     = "aws-terraform"

}

variable "public_subnet_cidr_blocks" {
  description = "List of AWS CIDR blocks to be used"
  type        = list(string)
  default     = ["10.0.0.0/27", "10.0.1.0/27"]
}

variable "public_subnet_az" {
  description = "Availability zones list"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}