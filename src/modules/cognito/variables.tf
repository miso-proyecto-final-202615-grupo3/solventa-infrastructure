variable "user_pool_name" {
  type = string
}

variable "client_names" {
  type = list(string)
}

variable "allowed_oauth_scopes" {
  type = list(string)
}

variable "allowed_oauth_flows_user_pool_client" {
  type = bool
}

variable "allowed_oauth_flows" {
  type = list(string)
}

variable "allowed_first_auth_factors" {
  type = list(string)
}

variable "explicit_auth_flows" {
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
