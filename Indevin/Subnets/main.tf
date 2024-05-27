

data "aws_availability_zones" "avzone" {
  state = "available"
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "subnet_private" {
  count             = var.availability_zones
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = var.subnet_private_prefixes[count.index]
  availability_zone = data.aws_availability_zones.avzone.names[count.index] //var.availability_zones[count.index]
  tags              = merge(var.tags, { "Name" = var.subnet_private_names[count.index] })
}

resource "aws_route_table" "route_table_private" {
  count  = var.availability_zones
  vpc_id = data.aws_vpc.vpc.id
  route {
      cidr_block = "10.0.0.0/8"
      transit_gateway_id = var.transit_gateway_id
    }
   route {
      cidr_block = "192.168.0.0/16"
      transit_gateway_id = var.transit_gateway_id
    }
    route {
      cidr_block = "172.16.0.0/12"
      transit_gateway_id = var.transit_gateway_id
    }
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = var.nat_gateway_id[count.index]
    }
  tags   = merge(var.tags, { "Name" = var.rt_private_names[count.index] })
}

resource "aws_route_table_association" "private" {
  count          = var.availability_zones
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}

# resource "aws_route" "routes" {

#   route_table_id = 
# }