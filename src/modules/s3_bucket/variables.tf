variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}

variable "kms_key_id" {
  description = "KMS key used for bucket encryption."
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}
