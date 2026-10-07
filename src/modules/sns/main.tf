resource "aws_sns_topic" "this" {
  name = var.topic_name

  kms_master_key_id = var.kms_master_key_id

  tags = merge(var.tags, { Name = var.topic_name })
}

resource "aws_sns_topic_subscription" "this" {
  count = length(var.endpoint_arns)

  topic_arn = aws_sns_topic.this.arn
  protocol  = var.protocols[count.index]
  endpoint  = var.endpoint_arns[count.index]
}

resource "aws_sns_topic_policy" "this" {
  arn = aws_sns_topic.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = var.principal_services }
      Action    = "SNS:Publish"
      Resource  = aws_sns_topic.this.arn
    }]
  })
}
