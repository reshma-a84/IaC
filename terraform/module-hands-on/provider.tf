terraform {

  backend "s3" {
    bucket = "30as7ln-s3-tfstate-bucket"
    key    = "hands-on/ec2-full"
    region = "ap-south-1"

  }
  required_version = "~> 1.5.0"
}