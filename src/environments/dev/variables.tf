variable "project" {
  description = "Project name used in resource names and tags."
  type        = string
}

variable "environment" {
  description = "Environment name used in resource names and tags."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the development VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Static CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_compute_subnet_cidrs" {
  description = "Static CIDR blocks for private compute subnets."
  type        = list(string)
}

variable "private_database_subnet_cidrs" {
  description = "Static CIDR blocks for private database subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones used by the VPC subnets."
  type        = list(string)
}

variable "alb_target_port" {
  description = "Port exposed by the application target group."
  type        = number
}

variable "alb_target_protocol" {
  description = "Protocol used by the application target group."
  type        = string
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN used by the HTTPS listener."
  type        = string
}

variable "alb_ssl_policy" {
  description = "TLS policy used by the HTTPS listener."
  type        = string
}

variable "alb_idle_timeout" {
  description = "Idle timeout for the application load balancer."
  type        = number
}

variable "alb_deletion_protection" {
  description = "Prevents deletion of the application load balancer."
  type        = bool
}

variable "alb_health_check_healthy_threshold" {
  description = "Number of successful health checks required for a target."
  type        = number
}

variable "alb_health_check_interval" {
  description = "Interval between application load balancer health checks."
  type        = number
}

variable "alb_health_check_path" {
  description = "Path used by the application load balancer health check."
  type        = string
}

variable "alb_health_check_timeout" {
  description = "Timeout for an application load balancer health check."
  type        = number
}

variable "alb_health_check_unhealthy_threshold" {
  description = "Number of failed health checks required to mark a target unhealthy."
  type        = number
}

variable "eks_cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "eks_enable_public_endpoint" {
  description = "Allows public access to the EKS API endpoint."
  type        = bool
}

variable "eks_public_endpoint_cidrs" {
  description = "CIDR blocks permitted to access the public EKS endpoint."
  type        = list(string)
}

variable "eks_cluster_log_types" {
  description = "EKS control plane log types to enable."
  type        = list(string)
}

variable "eks_instance_types" {
  description = "Instance types used by the EKS node group."
  type        = list(string)
}

variable "eks_desired_size" {
  description = "Desired number of EKS worker nodes."
  type        = number
}

variable "eks_min_size" {
  description = "Minimum number of EKS worker nodes."
  type        = number
}

variable "eks_max_size" {
  description = "Maximum number of EKS worker nodes."
  type        = number
}

variable "eks_max_unavailable" {
  description = "Maximum number of worker nodes that can be unavailable during updates."
  type        = number
}

variable "eks_capacity_type" {
  description = "Capacity type for the EKS node group."
  type        = string
}

variable "eks_disk_size" {
  description = "Root disk size in GiB for EKS worker nodes."
  type        = number
}

variable "eks_ami_type" {
  description = "Amazon Linux AMI type used by the EKS node group."
  type        = string
}

variable "eks_labels" {
  description = "Labels applied to EKS worker nodes."
  type        = map(string)
}

variable "assets_bucket_name" {
  description = "Globally unique name of the development assets bucket."
  type        = string
}

variable "kms_deletion_window_in_days" {
  description = "Waiting period before KMS key deletion."
  type        = number
}

variable "kms_enable_key_rotation" {
  description = "Enables automatic KMS key rotation."
  type        = bool
}

variable "aurora_engine_version" {
  description = "Aurora PostgreSQL engine version."
  type        = string
}

variable "aurora_database_name" {
  description = "Initial database name for Aurora PostgreSQL."
  type        = string
  sensitive   = true
}

variable "aurora_master_username" {
  description = "Master username for Aurora PostgreSQL."
  type        = string
  sensitive   = true
}

variable "aurora_master_password" {
  description = "Master password for Aurora PostgreSQL."
  type        = string
  sensitive   = true
}

variable "aurora_port" {
  description = "Port exposed by Aurora PostgreSQL."
  type        = number
}

variable "aurora_preferred_backup_window" {
  description = "Preferred maintenance window for Aurora backups."
  type        = string
}

variable "aurora_backup_retention_period" {
  description = "Number of days to retain Aurora backups."
  type        = number
}

variable "aurora_preferred_maintenance_window" {
  description = "Preferred maintenance window for Aurora."
  type        = string
}

variable "aurora_storage_encrypted" {
  description = "Enables encryption at rest for Aurora."
  type        = bool
}

variable "aurora_parameter_group_name" {
  description = "Parameter group name used by Aurora."
  type        = string
}

variable "aurora_parameter_group_family" {
  description = "Family of the Aurora parameter group."
  type        = string
}

variable "aurora_instance_count" {
  description = "Number of Aurora database instances."
  type        = number
}

variable "aurora_instance_class" {
  description = "EC2 instance class used by Aurora database instances."
  type        = string
}

variable "aurora_skip_final_snapshot" {
  description = "Skips final snapshot creation when destroying Aurora."
  type        = bool
}

variable "aurora_deletion_protection" {
  description = "Prevents deletion of the Aurora cluster."
  type        = bool
}

variable "aurora_apply_immediately" {
  description = "Applies Aurora changes immediately instead of waiting for maintenance."
  type        = bool
}

variable "sqs_visibility_timeout_seconds" {
  description = "Visibility timeout for messages in the events queue."
  type        = number
}

variable "sqs_message_retention_seconds" {
  description = "Retention period for messages in the events queue."
  type        = number
}

variable "sqs_redrive_policy" {
  description = "Optional JSON policy used for dead-letter queue routing."
  type        = string
}

variable "sqs_principal_services" {
  description = "AWS services allowed to publish to the events queue."
  type        = list(string)
}

variable "sns_endpoint_arns" {
  description = "Endpoint ARNs subscribed to the notifications topic."
  type        = list(string)
}

variable "sns_protocols" {
  description = "Protocols matching the notification endpoints."
  type        = list(string)
}

variable "sns_principal_services" {
  description = "AWS services allowed to publish to the notifications topic."
  type        = list(string)
}

variable "api_stage_name" {
  description = "Name of the API Gateway stage."
  type        = string
}

variable "api_route_key" {
  description = "Route key exposed by the API Gateway."
  type        = string
}

variable "api_access_log_retention_in_days" {
  description = "Retention period for API Gateway access logs."
  type        = number
}

variable "api_access_log_format" {
  description = "Format used for API Gateway access log records."
  type        = string
}

variable "cognito_username_attributes" {
  description = "Attributes users can sign in with."
  type        = list(string)
}

variable "cognito_client_names" {
  description = "Names of Cognito application clients."
  type        = list(string)
}

variable "cognito_allowed_oauth_scopes" {
  description = "OAuth scopes allowed for Cognito application clients."
  type        = list(string)
}

variable "cognito_supported_identity_providers" {
  description = "Identity providers supported by Cognito clients."
  type        = list(string)
}

variable "cognito_generate_secret" {
  description = "Generates an application client secret."
  type        = bool
}

variable "cognito_callback_urls" {
  description = "Callback URLs for Cognito application clients."
  type        = list(string)
}

variable "cognito_logout_urls" {
  description = "Logout URLs for Cognito application clients."
  type        = list(string)
}

variable "secrets_rotation_schedule_days" {
  description = "Days before Secrets Manager rotates a secret."
  type        = number
}

variable "secrets_rotation_lambda_arn" {
  description = "Lambda ARN used to rotate a secret."
  type        = string
}
