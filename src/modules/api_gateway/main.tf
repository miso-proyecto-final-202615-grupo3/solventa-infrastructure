resource "aws_apigatewayv2_api" "this" {
  name          = var.api_name
  description   = var.api_description
  protocol_type = "HTTP"

  tags = merge(var.tags, { Name = var.api_name })
}

resource "aws_cloudwatch_log_group" "access" {
  name              = "/aws/apigateway/${var.api_name}"
  retention_in_days = var.access_log_retention_in_days

  tags = merge(var.tags, { Name = "${var.api_name}-access-logs" })
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.stage_name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.access.arn
    format          = var.access_log_format
  }

  tags = merge(var.tags, { Name = var.stage_name })
}

resource "aws_apigatewayv2_integration" "this" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = var.integration_uri
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = var.route_key
  target    = aws_apigatewayv2_integration.this.id
}
