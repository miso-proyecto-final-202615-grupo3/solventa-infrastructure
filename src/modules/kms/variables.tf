variable "key_name" {
  type = string
}

variable "alias_name" {
  type = string
}

variable "description" {
  type = string
}

variable "deletion_window_in_days" {
  type = number
}

variable "enable_key_rotation" {
  type = bool
}

variable "tags" {
  type = map(string)
}
