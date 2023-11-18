resource "aws_api_gateway_rest_api" "hands_on_API_REST" {
  name = "${local.prefix}-api-gateway-rest"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "hands_on_resource" {
  path_part   = "${local.prefix}-api-resource"
  parent_id   = aws_api_gateway_rest_api.hands_on_API_REST.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.hands_on_API_REST.id
}

resource "aws_api_gateway_method" "hands_on_getMethod" {
  rest_api_id   = aws_api_gateway_rest_api.hands_on_API_REST.id
  resource_id   = aws_api_gateway_resource.hands_on_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "getMethod_integration" {
  rest_api_id             = aws_api_gateway_rest_api.hands_on_API_REST.id
  resource_id             = aws_api_gateway_resource.hands_on_resource.id
  http_method             = aws_api_gateway_method.hands_on_getMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.hands_on_Lambda.invoke_arn
  credentials             = aws_iam_role.api_role.arn
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = "{}"
  }
  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-amz-json-1.1'"
  }
}

resource "aws_api_gateway_method_response" "getMethod_response" {
  rest_api_id = aws_api_gateway_rest_api.hands_on_API_REST.id
  resource_id = aws_api_gateway_resource.hands_on_resource.id
  http_method = aws_api_gateway_method.hands_on_getMethod.http_method
  status_code = "200"

}

resource "aws_api_gateway_integration_response" "getMethod_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.hands_on_API_REST.id
  resource_id = aws_api_gateway_resource.hands_on_resource.id
  http_method = aws_api_gateway_method.hands_on_getMethod.http_method
  status_code = aws_api_gateway_method_response.getMethod_response.status_code

  depends_on = [aws_api_gateway_integration.getMethod_integration]
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.hands_on_API_REST.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.hands_on_API_REST.id,
      aws_api_gateway_resource.hands_on_resource.id,
      aws_api_gateway_method.hands_on_getMethod.id,
      aws_api_gateway_integration.getMethod_integration.id
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.hands_on_API_REST.id
  stage_name    = "dev"
}