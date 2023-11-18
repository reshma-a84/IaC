data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "hands_on_Lambda" {
  filename         = "lambda.zip"
  function_name    = "${local.prefix}-lambda-function"
  role             = aws_iam_role.lambda_iam_role.arn
  handler          = "lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.9"
  timeout          = 900
  environment {
    variables = {
      iam = aws_iam_role.api_role.arn,
    foo = "bar" }
  }
}