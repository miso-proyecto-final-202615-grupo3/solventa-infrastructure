variable "cluster_identifier" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "database_name" {
  type      = string
  sensitive = true
}

variable "master_username" {
  type      = string
  sensitive = true
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "port" {
  type = number
}

variable "preferred_backup_window" {
  type = string
}

variable "backup_retention_period" {
  type = number
}

variable "preferred_maintenance_window" {
  type = string
}

variable "storage_encrypted" {
  type = bool
}

variable "kms_key_id" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "parameter_group_family" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_count" {
  type = number
}

variable "instance_class" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "apply_immediately" {
  type = bool
}

variable "tags" {
  type = map(string)
}
