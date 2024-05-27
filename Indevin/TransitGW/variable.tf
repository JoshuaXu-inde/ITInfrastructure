
variable "profile_first" {
  type = string
}

variable "profile_second" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "transit_gw_name" {
  type        = string
  default     = "tgw-022b53fee4b0e345b"
  description = "transit gateway name"
}

variable "transit_gw_id" {
  type        = string
  default     = "tgw-022b53fee4b0e345b"
  description = "transit gateway name"
}

variable "availability_zones" {
  type    = number
  default = 2
}

variable "vpc_first_id" {
  type = string
}

variable "subnet_first_names" {
  type = list(string)
}

variable "subnet_first_cidr_blocks" {
  type = list(string)
}

variable "vpc_second_id" {
  type = string
}

variable "subnet_second_names" {
  type = list(string)
}

variable "subnet_second_cidr_blocks" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

