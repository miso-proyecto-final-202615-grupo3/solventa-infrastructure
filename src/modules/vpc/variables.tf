variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_compute_subnet_cidrs" {
  type = list(string)
}

variable "private_database_subnet_cidrs" {
  type = list(string)
}

variable "internet_gateway_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "subnet_name_prefix" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
