resource "aws_sqs_queue" "this" {
  name                       = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  kms_master_key_id          = var.kms_master_key_id
  redrive_policy             = var.redrive_policy
  tags                       = merge(var.tags, { Name = var.queue_name })
}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = var.principal_services }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.this.arn
    }]
  })
}
