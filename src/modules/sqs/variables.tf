variable "queue_name" {
  type = string
}

variable "visibility_timeout_seconds" {
  type = number
}

variable "message_retention_seconds" {
  type = number
}

variable "kms_master_key_id" {
  type = string
}

variable "redrive_policy" {
  type    = string
  default = null
}

variable "principal_services" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
