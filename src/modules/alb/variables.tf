variable "load_balancer_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_port" {
  type = number
}

variable "target_protocol" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "ssl_policy" {
  type = string
}

variable "idle_timeout" {
  type = number
}

variable "deletion_protection" {
  type = bool
}

variable "health_check_healthy_threshold" {
  type = number
}

variable "health_check_interval" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "health_check_timeout" {
  type = number
}

variable "health_check_unhealthy_threshold" {
  type = number
}

variable "tags" {
  type = map(string)
}
