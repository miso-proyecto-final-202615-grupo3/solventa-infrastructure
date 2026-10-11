variable "replication_group_id" {
  description = "Identifier used for the Redis replication group and related resources."
  type        = string
}

variable "description" {
  description = "Description of the Redis replication group."
  type        = string
}

variable "engine_version" {
  description = "Redis engine version."
  type        = string
}

variable "node_type" {
  description = "ElastiCache node type used by the Redis replication group."
  type        = string
}

variable "port" {
  description = "Port used by Redis."
  type        = number
}

variable "num_cache_clusters" {
  description = "Number of cache nodes in the replication group."
  type        = number
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic snapshots."
  type        = number
}

variable "apply_immediately" {
  description = "Applies Redis changes immediately instead of waiting for the maintenance window."
  type        = bool
}

variable "at_rest_encryption_enabled" {
  description = "Enables encryption at rest for Redis."
  type        = bool
}

variable "transit_encryption_enabled" {
  description = "Enables TLS encryption for Redis connections."
  type        = bool
}

variable "auth_token" {
  description = "Authentication token required by Redis clients."
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC hosting the Redis resources."
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks permitted to connect to Redis."
  type        = list(string)
}

variable "subnet_ids" {
  description = "Private subnet IDs used by the Redis subnet group."
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}