variable "user_pool_name" {
  type = string
}

variable "username_attributes" {
  type = list(string)
}

variable "client_names" {
  type = list(string)
}

variable "allowed_oauth_scopes" {
  type = list(string)
}

variable "supported_identity_providers" {
  type = list(string)
}

variable "generate_secret" {
  type = bool
}

variable "callback_urls" {
  type = list(string)
}

variable "logout_urls" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
