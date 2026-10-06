output "assets_bucket_name" {
  description = "Name of the environment assets bucket."
  value       = module.assets_bucket.bucket_name
}

output "assets_bucket_arn" {
  description = "ARN of the environment assets bucket."
  value       = module.assets_bucket.bucket_arn
}
