variable "topic_name" {
  type = string
}

variable "kms_master_key_id" {
  type = string
}

variable "endpoint_arns" {
  type = list(string)
}

variable "protocols" {
  type = list(string)
}

variable "principal_services" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
