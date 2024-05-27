variable "profile" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_name" {
  type = string
}

variable "vpc_address_space" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "natgw_ip_names" {
  type = list(string)
}

variable "natgw_names" {
  type = list(string)
}

variable "transit_gateway_id" {
  type = string
}

variable "subnet_public_names" {
  type = list(string)
}
variable "subnet_private_names" {
  type = list(string)
}

variable "subnet_public_prefixes" {
  type = list(string)
}

variable "subnet_private_prefixes" {
  type = list(string)
}

variable "rt_public_names" {
  type = list(string)
}

variable "rt_private_names" {
  type = list(string)
}

variable "availability_zones" {
  type    = number
  default = 2
}

variable "tags" {
  type = map(string)
}
