resource "aws_iam_role" "ec2-iam-role" {
    name = var.ec2-role-name
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })  
}



# data "aws_iam_policy_document" "instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "instance1" {
#   name               = var.instance_role_1 
#   path               = var.instance_path
#   assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
# }