variable "bucket_name" {
  description = "Globally unique name for the private frontend bucket."
  type        = string
}

variable "api_origin_domain_name" {
  description = "DNS name of the ALB serving the backend API. When set, requests to /api/* are forwarded to it without caching. When null, no API origin is created."
  type        = string
}

variable "api_origin_protocol_policy" {
  description = "Protocol CloudFront uses to reach the API origin (http-only, https-only or match-viewer)."
  type        = string

  validation {
    condition     = contains(["http-only", "https-only", "match-viewer"], var.api_origin_protocol_policy)
    error_message = "api_origin_protocol_policy must be http-only, https-only or match-viewer."
  }
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}
