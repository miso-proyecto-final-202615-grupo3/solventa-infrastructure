variable "repository_names" {
  type = list(string)
}

variable "image_tag_mutability" {
  type = string
}

variable "scan_on_push" {
  type = bool
}

variable "encryption_type" {
  type = string
}

variable "keep_latest_images" {
  type = number
}

variable "tags" {
  type = map(string)
}
