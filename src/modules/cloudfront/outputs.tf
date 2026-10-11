output "bucket_name" {
  description = "Name of the private frontend bucket."
  value       = aws_s3_bucket.frontend.id
}

output "distribution_id" {
  description = "ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.frontend.id
}

output "distribution_domain_name" {
  description = "Domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.frontend.domain_name
}