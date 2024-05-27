variable "region" {
  type = string
}
variable "profile" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "transit_gw_id" {
  type = string
}
data "aws_route_table" "route_tables" {
  count = length(var.subnet_ids)
  subnet_id = var.subnet_ids[count.index]
}

resource "aws_route" "route-10" {
  count = length(var.subnet_ids)
  route_table_id = data.aws_route_table.route_tables.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id = var.transit_gw_id
}

resource "aws_route" "route-172" {
  count = length(var.subnet_ids)
  route_table_id = data.aws_route_table.route_tables.id
  destination_cidr_block = "172.16.0.0/12"
  transit_gateway_id = var.transit_gw_id
}

resource "aws_route" "route-192" {
  count = length(var.subnet_ids)
  route_table_id = data.aws_route_table.route_tables.id
  destination_cidr_block = "192.168.0.0/16"
  transit_gateway_id = var.transit_gw_id
}