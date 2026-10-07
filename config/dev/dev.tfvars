project     = "solventa"
environment = "dev"

tags = {
}

vpc_cidr = "10.100.0.0/16"

public_subnet_cidrs = [
  "10.100.1.0/24",
  "10.100.2.0/24",
  "10.100.3.0/24",
]

private_compute_subnet_cidrs = [
  "10.100.10.0/24",
  "10.100.11.0/24",
  "10.100.12.0/24",
]

private_database_subnet_cidrs = [
  "10.100.20.0/24",
  "10.100.21.0/24",
  "10.100.22.0/24",
]

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

alb_target_port                      = 8080
alb_target_protocol                  = "HTTP"
certificate_arn                      = ""
alb_ssl_policy                       = "ELBSecurityPolicy-TLS-1-2-2017-01"
alb_idle_timeout                     = 60
alb_deletion_protection              = false
alb_health_check_healthy_threshold   = 2
alb_health_check_interval            = 30
alb_health_check_path                = "/health"
alb_health_check_timeout             = 5
alb_health_check_unhealthy_threshold = 2

eks_cluster_version        = "1.37"
eks_enable_public_endpoint = false
eks_public_endpoint_cidrs  = []
eks_cluster_log_types      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
eks_instance_types         = ["m5.large"]
eks_desired_size           = 1
eks_min_size               = 1
eks_max_size               = 2
eks_max_unavailable        = 1
eks_capacity_type          = "ON_DEMAND"
eks_disk_size              = 40
eks_ami_type               = "AL2023_x86_64_STANDARD"
eks_labels = {
  Environment = "dev"
  Workload    = "solventa-backend"
}

aurora_engine_version               = "18.6"
aurora_port                         = 5432
aurora_preferred_backup_window      = "03:00-04:00"
aurora_backup_retention_period      = 7
aurora_preferred_maintenance_window = "sun:04:00-sun:05:00"
aurora_storage_encrypted            = true
aurora_parameter_group_name         = "solventa-dev-aurora"
aurora_parameter_group_family       = "aurora-postgresql-18.6"
aurora_instance_count               = 1
aurora_instance_class               = "db.t3.small"
aurora_skip_final_snapshot          = true
aurora_deletion_protection          = false
aurora_apply_immediately            = false

assets_bucket_name = "solventa-dev-assets-6f2c0a"

cognito_client_names                  = ["solventa-dev-web", "solventa-dev-mobile"]
cognito_allowed_oauth_scopes          = ["openid", "email", "profile"]
cognito_supported_identity_providers  = []
cognito_generate_secret               = true
cognito_callback_urls                 = []
cognito_logout_urls                   = []

api_stage_name                   = "dev"
api_route_key                    = "$default"
api_access_log_retention_in_days = 30
api_access_log_format            = "{\"requestId\":\"$context.requestId\",\"ip\":\"$context.identity.sourceIp\",\"requestTime\":\"$context.requestTime\",\"httpMethod\":\"$context.httpMethod\",\"routeKey\":\"$context.routeKey\",\"status\":$context.status,\"protocol\":\"$context.protocol\",\"responseLength\":$context.responseLength}"

sqs_visibility_timeout_seconds = 300
sqs_message_retention_seconds  = 1209600
sqs_principal_services         = ["sns.amazonaws.com"]
sqs_redrive_policy             = ""

sns_principal_services = ["sqs.amazonaws.com"]
sns_endpoint_arns      = []
sns_protocols          = []

kms_deletion_window_in_days = 30
kms_enable_key_rotation     = true

secrets_rotation_schedule_days = 0
secrets_rotation_lambda_arn    = ""
