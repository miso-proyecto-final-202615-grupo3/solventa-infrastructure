variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "enable_public_endpoint" {
  type = bool
}

variable "public_endpoint_cidrs" {
  type = list(string)
}

variable "cluster_log_types" {
  type = list(string)
}

variable "cluster_admin_principal_arn_pipeline" {
  type = string
}

variable "cluster_admin_principal_arn_group" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "max_unavailable" {
  type = number
}

variable "capacity_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "ami_type" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}
