resource "aws_iam_role" "lambda_iam_role" {
  name               = "${local.prefix}-lambda-iam-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_all_policies" {
  role = aws_iam_role.lambda_iam_role.name
  for_each = toset(["arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AmazonKinesisFullAccess",
  "arn:aws:iam::aws:policy/AmazonSQSFullAccess"])
  policy_arn = each.value

}

resource "aws_iam_role" "api_role" {
  name               = "${local.prefix}-api-iam-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "apigateway.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "api_all_policies" {
  role = aws_iam_role.api_role.name
  # for_each = toset(["arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess",
  # "arn:aws:iam::aws:policy/AWSLambda_FullAccess"])
  # policy_arn = each.value
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"

}