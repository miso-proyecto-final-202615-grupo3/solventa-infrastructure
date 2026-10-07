module "vpc" {
  source = "../../modules/vpc"

  vpc_name                      = "${var.project}-${var.environment}-vpc"
  vpc_cidr                      = var.vpc_cidr
  public_subnet_cidrs           = var.public_subnet_cidrs
  private_compute_subnet_cidrs  = var.private_compute_subnet_cidrs
  private_database_subnet_cidrs = var.private_database_subnet_cidrs
  internet_gateway_name         = "${var.project}-${var.environment}-igw"
  nat_gateway_name              = "${var.project}-${var.environment}-nat"
  subnet_name_prefix            = "${var.project}-${var.environment}"
  public_route_table_name       = "${var.project}-${var.environment}-public-rt"
  private_route_table_name      = "${var.project}-${var.environment}-private-rt"
  availability_zones            = var.availability_zones
  tags                          = var.tags
}

module "application_load_balancer" {
  source = "../../modules/alb"

  load_balancer_name               = "${var.project}-${var.environment}-alb"
  target_group_name                = "${var.project}-${var.environment}-tg"
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.public_subnet_ids
  target_port                      = var.alb_target_port
  target_protocol                  = var.alb_target_protocol
  certificate_arn                  = var.alb_certificate_arn
  ssl_policy                       = var.alb_ssl_policy
  idle_timeout                     = var.alb_idle_timeout
  deletion_protection              = var.alb_deletion_protection
  health_check_healthy_threshold   = var.alb_health_check_healthy_threshold
  health_check_interval            = var.alb_health_check_interval
  health_check_path                = var.alb_health_check_path
  health_check_timeout             = var.alb_health_check_timeout
  health_check_unhealthy_threshold = var.alb_health_check_unhealthy_threshold
  tags                             = var.tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name           = "${var.project}-${var.environment}-eks"
  cluster_version        = var.eks_cluster_version
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr               = module.vpc.vpc_cidr
  private_subnet_ids     = module.vpc.private_compute_subnet_ids
  enable_public_endpoint = var.eks_enable_public_endpoint
  public_endpoint_cidrs  = var.eks_public_endpoint_cidrs
  cluster_log_types      = var.eks_cluster_log_types
  node_group_name        = "${var.project}-${var.environment}-workers"
  instance_types         = var.eks_instance_types
  desired_size           = var.eks_desired_size
  min_size               = var.eks_min_size
  max_size               = var.eks_max_size
  max_unavailable        = var.eks_max_unavailable
  capacity_type          = var.eks_capacity_type
  disk_size              = var.eks_disk_size
  ami_type               = var.eks_ami_type
  labels                 = var.eks_labels
  tags                   = var.tags
}

module "ecr" {
  source = "../../modules/ecr"

  repository_names     = var.ecr_repository_names
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  encryption_type      = var.ecr_encryption_type
  keep_latest_images   = var.ecr_keep_latest_images
  tags                 = var.tags
}

# module "aurora" {
#   source = "../../modules/aurora"

#   cluster_identifier           = "${var.project}-${var.environment}-aurora"
#   engine_version               = var.aurora_engine_version
#   database_name                = var.aurora_database_name
#   master_username              = var.aurora_master_username
#   master_password              = var.aurora_master_password
#   port                         = var.aurora_port
#   preferred_backup_window      = var.aurora_preferred_backup_window
#   backup_retention_period      = var.aurora_backup_retention_period
#   preferred_maintenance_window = var.aurora_preferred_maintenance_window
#   storage_encrypted            = var.aurora_storage_encrypted
#   kms_key_id                   = module.kms.key_id
#   parameter_group_name         = var.aurora_parameter_group_name
#   parameter_group_family       = var.aurora_parameter_group_family
#   vpc_id                       = module.vpc.vpc_id
#   vpc_cidr                     = module.vpc.vpc_cidr
#   subnet_group_name            = "${var.project}-${var.environment}-aurora-subnets"
#   subnet_ids                   = module.vpc.private_database_subnet_ids
#   instance_count               = var.aurora_instance_count
#   instance_class               = var.aurora_instance_class
#   skip_final_snapshot          = var.aurora_skip_final_snapshot
#   deletion_protection          = var.aurora_deletion_protection
#   apply_immediately            = var.aurora_apply_immediately
#   tags                         = var.tags
# }

# module "assets_bucket" {
#   source = "../../modules/s3_bucket"

#   bucket_name = var.assets_bucket_name
#   kms_key_id  = module.kms.key_id
#   tags        = var.tags
# }

# module "cognito" {
#   source = "../../modules/cognito"

#   user_pool_name               = "${var.project}-${var.environment}-cognito-customers"
#   client_names                 = var.cognito_client_names
#   allowed_oauth_scopes         = var.cognito_allowed_oauth_scopes
#   supported_identity_providers = var.cognito_supported_identity_providers
#   generate_secret              = var.cognito_generate_secret
#   callback_urls                = var.cognito_callback_urls
#   logout_urls                  = var.cognito_logout_urls
#   tags                         = var.tags
# }

# module "api_gateway" {
#   source = "../../modules/api_gateway"

#   api_name                     = "${var.project}-${var.environment}-apigw"
#   api_description              = "Solventa API Gateway for ${var.environment}"
#   stage_name                   = var.api_stage_name
#   integration_uri              = "http://${module.application_load_balancer.load_balancer_dns_name}"
#   route_key                    = var.api_route_key
#   access_log_retention_in_days = var.api_access_log_retention_in_days
#   access_log_format            = var.api_access_log_format
#   tags                         = var.tags
# }

# module "events_queue" {
#   source = "../../modules/sqs"

#   queue_name                 = "${var.project}-${var.environment}-events"
#   visibility_timeout_seconds = var.sqs_visibility_timeout_seconds
#   message_retention_seconds  = var.sqs_message_retention_seconds
#   kms_master_key_id          = module.kms.key_id
#   redrive_policy             = var.sqs_redrive_policy
#   principal_services         = var.sqs_principal_services
#   tags                       = var.tags
# }

# module "notifications_topic" {
#   source = "../../modules/sns"

#   topic_name         = "${var.project}-${var.environment}-notifications"
#   kms_master_key_id  = module.kms.key_id
#   endpoint_arns      = var.sns_endpoint_arns
#   protocols          = var.sns_protocols
#   principal_services = var.sns_principal_services
#   tags               = var.tags
# }

# module "kms" {
#   source = "../../modules/kms"

#   key_name                = "${var.project}-${var.environment}-key"
#   alias_name              = "alias/${var.project}-${var.environment}"
#   description             = "KMS key for Solventa ${var.environment} secrets and data"
#   deletion_window_in_days = var.kms_deletion_window_in_days
#   enable_key_rotation     = var.kms_enable_key_rotation
#   tags                    = var.tags
# }

# module "secrets_manager" {
#   source = "../../modules/secrets_manager"

#   secret_name            = "${var.project}-${var.environment}-secrets"
#   kms_key_id             = module.kms.key_id
#   rotation_schedule_days = var.secrets_rotation_schedule_days
#   rotation_lambda_arn    = var.secrets_rotation_lambda_arn
#   tags                   = var.tags
# }