/*
create a transit gateway and attach a VPC to the gw in the account
share the transit gw to the second account and attach a vpc to the gw
assuming the two VPCs are deployed ahead
*/

data "aws_availability_zones" "avzone_first" {
  provider = aws.first
  state    = "available"
}
data "aws_vpc" "vpc_first" {
  provider = aws.first
  id       = var.vpc_first_id
}
resource "aws_subnet" "subnet_transitgw" {
  provider          = aws.first
  count             = var.availability_zones
  vpc_id            = data.aws_vpc.vpc_first.id
  cidr_block        = var.subnet_first_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.avzone_first.names[count.index] //var.availability_zones[count.index]
  tags              = merge(var.tags, { "Name" = var.subnet_first_names[count.index] })
}

# resource "aws_ec2_transit_gateway" "transit_gw" {
#   provider = aws.first
#   description = "transit gateway resource"
#   auto_accept_shared_attachments = "enable"
#   default_route_table_association = "enable"
#   default_route_table_propagation = "enable"
#   tags = merge(var.tags, {"Name" = var.transit_gw_name})
# }

data "aws_ec2_transit_gateway" "transit_gw" {
  provider = aws.first
  id       = var.transit_gw_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachment" {
  provider = aws.first
  subnet_ids = [
    for i in range(var.availability_zones) :
  aws_subnet.subnet_transitgw[i].id]
  transit_gateway_id = data.aws_ec2_transit_gateway.transit_gw.id
  vpc_id             = aws_vpc.vpc.id
}

resource "aws_ram_resource_share" "share_transit_gw" {
  provider = aws.first
  name     = "share_transit_gateway"
  tags     = merge(var.tags, { "Name" = "share_transit_gateway" })
}

# Share the transit Gateway
resource "aws_ram_resource_association" "association" {
  provider           = aws.first
  resource_arn       = data.aws_ec2_transit_gateway.transit_gw.arn
  resource_share_arn = aws_ram_resource_share.share_transit_gw.id
}


data "aws_caller_identity" "caller_identity" {
  provider = aws.second
}
resource "aws_ram_principal_association" "principal_association" {
  provider           = aws.first
  principal          = data.aws_caller_identity.caller_identity.id
  resource_share_arn = aws_ram_resource_share.share_transit_gw.id
}

# resources in the second account
data "aws_availability_zones" "avzone_second" {
  provider = aws.second
  state    = "available"
}
data "aws_vpc" "vpc_second" {
  id = var.vpc_second_id
}

resource "aws_subnet" "subnet_second_transitgw" {
  provider          = aws.second
  count             = var.availability_zones
  vpc_id            = data.aws_vpc.vpc_second.id
  cidr_block        = var.subnet_first_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.avzone_second.names[count.index] //var.availability_zones[count.index]
  tags              = merge(var.tags, { "Name" = var.subnet_second_names[count.index] })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_second_attachment" {
  provider = aws.second
  subnet_ids = [
    for i in range(var.availability_zones) :
  aws_subnet.subnet_second_transitgw[i].id]
  transit_gateway_id = data.aws_ec2_transit_gateway.transit_gw.id
  vpc_id             = aws_vpc.vpc.id
}


