variable "bucket_name" {
  description = "Globally unique name for the private frontend bucket."
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}

variable "api_origin_domain" {
  description = "DNS name of the backend load balancer. When set, CloudFront proxies /api/* to it. Null disables the API origin."
  type        = string
  default     = null
}

variable "api_origin_protocol_policy" {
  description = "Protocol CloudFront uses to reach the API origin (http-only, https-only or match-viewer)."
  type        = string
  default     = "http-only"
}
