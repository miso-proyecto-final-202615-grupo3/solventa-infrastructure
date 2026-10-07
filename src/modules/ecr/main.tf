resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  tags = merge(var.tags, {
    Name = each.value
  })
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = aws_ecr_repository.this

  repository = each.value.name

  policy = jsonencode({
    rules = [{
      action = {
        type = "expire"
      }
      description = "Keep the latest ${var.keep_latest_images} image tags"
      filter = {
        tagStatus = "tagged"
      }
      count_type   = "number"
      count_number = var.keep_latest_images
    }]
  })
}
