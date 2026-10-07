variable "secret_name" {
  type = string
}

variable "kms_key_id" {
  type = string
}

variable "rotation_schedule_days" {
  type = number
}

variable "rotation_lambda_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}
