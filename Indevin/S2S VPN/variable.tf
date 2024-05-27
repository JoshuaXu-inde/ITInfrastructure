variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "profile" {
  type    = string
  default = "indevin_network"
}

variable "transit_gateway_id" {
  type        = string
  default     = "tgw-022b53fee4b0e345b"
  description = "transit gateway name"
}

variable "bgp_asn" {
  type = string
}
variable "customer_gw_ip" {
  type = string
}

variable "tunnel_preshared_key" {
  type    = string
  default = "72G9-XLeJ9bUg.Aa!u!z"
}

variable "phase1_dh_group" {
  type    = number
  default = 14
}

variable "phase2_dh_group" {
  type    = number
  default = 14
}

variable "tunnel1_inside_cidr" {
  type = string
}

variable "tunnel2_inside_cidr" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "customer_gateway_name" {
  type = string
}

variable "vpn_connection_name" {
  type = string
}