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
alb_certificate_arn                  = ""
alb_ssl_policy                       = "ELBSecurityPolicy-TLS-1-2-2017-01"
alb_idle_timeout                     = 60
alb_deletion_protection              = false
alb_health_check_healthy_threshold   = 2
alb_health_check_interval            = 30
alb_health_check_path                = "/health"
alb_health_check_timeout             = 5
alb_health_check_unhealthy_threshold = 2

eks_cluster_version        = "1.37"
eks_enable_public_endpoint = true
eks_public_endpoint_cidrs  = ["0.0.0.0/0"]
eks_cluster_log_types      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
eks_instance_types         = ["m7i-flex.large"]
eks_desired_size           = 1
eks_min_size               = 1
eks_max_size               = 3
eks_max_unavailable        = 1
eks_capacity_type          = "ON_DEMAND"
eks_disk_size              = 40
eks_ami_type               = "AL2023_x86_64_STANDARD"
eks_labels = {
  Environment = "dev"
  Workload    = "solventa-backend"
}

ecr_repository_names = [
  "solventa-identityprofiling-service",
  "solventa-quotingengine-service",
  "solventa-insurancepolicies-service",
  "solventa-insuranceclaims-service",
  "solventa-payments-service",
  "solventa-webbff-service",
  "solventa-mobilebff-service",
  "solventa-webapp"
]
ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true
ecr_encryption_type      = "AES256"
ecr_keep_latest_images   = 14

rds_engine_version               = "18.6"
rds_port                         = 5432
rds_preferred_backup_window      = "03:00-04:00"
rds_backup_retention_period      = 1
rds_preferred_maintenance_window = "sun:04:00-sun:05:00"
rds_allocated_storage            = 20
rds_max_allocated_storage        = 20
rds_storage_encrypted            = true
rds_parameter_group_family       = "postgres18"
rds_instance_count               = 1
rds_instance_class               = "db.t3.micro"
rds_skip_final_snapshot          = true
rds_deletion_protection          = false
rds_apply_immediately            = false

rds_serverlessv2_max_capacity             = 1.0
rds_serverlessv2_min_capacity             = 0.0
rds_serverlessv2_seconds_until_auto_pause = 3600

storage_bucket_name = "solventa-dev-storage-6fba06c21ab7"

cognito_allowed_first_auth_factors           = ["PASSWORD", "EMAIL_OTP"]
cognito_client_names                         = ["solventa-dev-web", "solventa-dev-mobile"]
cognito_explicit_auth_flows                  = ["ALLOW_USER_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
cognito_allowed_oauth_flows_user_pool_client = true
cognito_allowed_oauth_flows                  = []
cognito_allowed_oauth_scopes                 = []
cognito_generate_secret                      = false
cognito_callback_urls                        = []
cognito_logout_urls                          = []

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

data_kms_key_name                    = "solventa-dev-kms-key-appdata"
data_kms_key_alias_name              = "alias/solventa-dev-appdata-key"
data_kms_key_description             = "KMS key for Solventa dev application data"
data_kms_key_deletion_window_in_days = 30
data_kms_key_enable_key_rotation     = true
