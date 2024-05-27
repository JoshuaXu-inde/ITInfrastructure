variable "profile" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_id" {
  type = string
}

variable "subnet_private_names" {
  type = list(string)
}

variable "subnet_private_prefixes" {
  type = list(string)
}

variable "rt_private_names" {
  type = list(string)
}

variable "availability_zones" {
  type    = number
  default = 2
}

variable "transit_gateway_id" {
  type = string
  default = "tgw-022b53fee4b0e345b"
}

variable "nat_gateway_id" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
