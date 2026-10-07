resource "aws_secretsmanager_secret" "this" {
  name       = var.secret_name
  kms_key_id = var.kms_key_id

  tags = merge(var.tags, { Name = var.secret_name })
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count = var.rotation_schedule_days > 0 ? 1 : 0

  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.rotation_schedule_days
  }
}
