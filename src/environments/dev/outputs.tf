output "vpc_id" {
  description = "ID of the development VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the development VPC."
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_compute_subnet_ids" {
  description = "IDs of the private compute subnets."
  value       = module.vpc.private_compute_subnet_ids
}

output "private_database_subnet_ids" {
  description = "IDs of the private database subnets."
  value       = module.vpc.private_database_subnet_ids
}

output "load_balancer_arn" {
  description = "ARN of the application load balancer."
  value       = module.application_load_balancer.load_balancer_arn
}

# output "eks_cluster_id" {
#   description = "ID of the development EKS cluster."
#   value       = module.eks.cluster_id
# }

# output "eks_cluster_endpoint" {
#   description = "Endpoint of the development EKS cluster."
#   value       = module.eks.cluster_endpoint
# }

output "aurora_cluster_endpoint" {
  description = "Endpoint of the Aurora PostgreSQL cluster."
  value       = module.aurora.cluster_endpoint
}

output "assets_bucket_name" {
  description = "Name of the environment assets bucket."
  value       = module.storage_bucket.bucket_name
}

output "assets_bucket_arn" {
  description = "ARN of the environment assets bucket."
  value       = module.storage_bucket.bucket_arn
}

# output "api_gateway_endpoint" {
#   description = "Endpoint of the API Gateway."
#   value       = module.api_gateway.api_endpoint
# }

# output "events_queue_url" {
#   description = "URL of the development events queue."
#   value       = module.events_queue.queue_url
# }

# output "notifications_topic_arn" {
#   description = "ARN of the development notifications topic."
#   value       = module.notifications_topic.topic_arn
# }
