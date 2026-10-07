output "repository_arns" {
  value = {
    for name, repository in aws_ecr_repository.this : name => repository.arn
  }
}

output "repository_names" {
  value = {
    for name, repository in aws_ecr_repository.this : name => repository.name
  }
}

output "repository_urls" {
  value = {
    for name, repository in aws_ecr_repository.this : name => repository.repository_url
  }
}
