/*
create an AWS VPC and its children resources:
1. VPC
2. two public subnets in two different Availability Zone
3. two private subnets in two different Availability Zone
4. an Internet Gateway
5. two Nat Gateway in two different Availability Zone
If the transit Gateway exist, create the attachment and route tables

*/

data "aws_availability_zones" "avzone" {
  state = "available"
}

# data "aws_ec2_transit_gateway" "transit_gw" {
#   id = var.transit_gateway_id
# }

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_address_space
  enable_dns_hostnames = true // option required for tasks that run on Fargate
  //https://repost.aws/knowledge-center/ecs-problems-with-efs-dns-name
  enable_dns_support = true
  tags       = merge(var.tags, { "Name" = var.vpc_name })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, { "Name" = var.internet_gateway_name })
}

resource "aws_eip" "natgw_pip" {
  count      = var.availability_zones
  domain     = "vpc"
  tags       = merge(var.tags, { "Name" = var.natgw_ip_names[count.index] })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "natgw" {
  count         = var.availability_zones
  allocation_id = aws_eip.natgw_pip[count.index].id
  subnet_id     = aws_subnet.subnet_public[count.index].id
  tags          = merge(var.tags, { "Name" = var.natgw_names[count.index] })
  depends_on    = [aws_internet_gateway.igw]
}


resource "aws_subnet" "subnet_public" {
  count             = var.availability_zones
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_public_prefixes[count.index]
  availability_zone = data.aws_availability_zones.avzone.names[count.index] //var.availability_zones[count.index]
  tags              = merge(var.tags, { "Name" = var.subnet_public_names[count.index] })
}

resource "aws_subnet" "subnet_private" {
  count             = var.availability_zones
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_prefixes[count.index]
  availability_zone = data.aws_availability_zones.avzone.names[count.index] //var.availability_zones[count.index]
  tags              = merge(var.tags, { "Name" = var.subnet_private_names[count.index] })
}


# resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attach" {
#   transit_gateway_id = var.transit_gateway_id
#   vpc_id             = aws_vpc.vpc.id
#   subnet_ids = [
#     for i in range(var.availability_zones) :
#     aws_subnet.subnet_private[i].id
#   ]
#   tags       = merge(var.tags, { "Name" = "attach_${var.vpc_name}" })
#   depends_on = [aws_subnet.subnet_private]
# }


resource "aws_route_table" "route_table_public" {
  count  = var.availability_zones
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { "Name" = var.rt_public_names[count.index] })
}

resource "aws_route_table" "route_table_private" {
  count  = var.availability_zones
  vpc_id = aws_vpc.vpc.id
  # route {
  #   cidr_block         = "10.0.0.0/8"
  #   transit_gateway_id = var.transit_gateway_id
  # }
  # route {
  #   cidr_block         = "192.168.0.0/16"
  #   transit_gateway_id = var.transit_gateway_id
  # }
  # route {
  #   cidr_block         = "172.16.0.0/12"
  #   transit_gateway_id = var.transit_gateway_id
  # }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw[count.index].id
  }
  tags       = merge(var.tags, { "Name" = var.rt_private_names[count.index] })
  # depends_on = [aws_ec2_transit_gateway_vpc_attachment.vpc_attach]
}

resource "aws_route_table_association" "public" {
  count          = var.availability_zones
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.route_table_public[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = var.availability_zones
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}