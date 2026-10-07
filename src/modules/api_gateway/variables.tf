variable "api_name" {
  type = string
}

variable "api_description" {
  type = string
}

variable "stage_name" {
  type = string
}

variable "integration_uri" {
  type = string
}

variable "route_key" {
  type = string
}

variable "access_log_retention_in_days" {
  type = number
}

variable "access_log_format" {
  type = string
}

variable "tags" {
  type = map(string)
}
