

data "aws_ec2_transit_gateway" "transit_gw" {
  id = var.transit_gateway_id
}

resource "aws_customer_gateway" "customer_gw" {
  bgp_asn    = var.bgp_asn
  ip_address = var.customer_gw_ip
  type       = "ipsec.1"
  tags       = merge(var.tags, { "Name" = var.customer_gateway_name })
}

resource "aws_vpn_connection" "vpn_connection" {
  customer_gateway_id                  = aws_customer_gateway.customer_gw.id
  transit_gateway_id                   = data.aws_ec2_transit_gateway.transit_gw.id
  type                                 = aws_customer_gateway.customer_gw.type
  static_routes_only                   = false
  tunnel1_ike_versions                 = ["ikev2"]
  tunnel1_preshared_key                = var.tunnel_preshared_key
  tunnel1_phase1_dh_group_numbers      = [var.phase1_dh_group]
  tunnel1_inside_cidr                  = var.tunnel1_inside_cidr
  tunnel1_phase1_encryption_algorithms = ["AES256-GCM-16", "AES256"]
  tunnel1_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase1_lifetime_seconds      = 28800
  tunnel1_phase2_dh_group_numbers      = [var.phase2_dh_group]
  tunnel1_phase2_encryption_algorithms = ["AES256-GCM-16", "AES256"]
  tunnel1_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel1_phase2_lifetime_seconds      = 3600

  tunnel2_ike_versions                 = ["ikev2"]
  tunnel2_preshared_key                = var.tunnel_preshared_key
  tunnel2_phase1_dh_group_numbers      = [var.phase1_dh_group]
  tunnel2_inside_cidr                  = var.tunnel2_inside_cidr
  tunnel2_phase1_encryption_algorithms = ["AES256-GCM-16", "AES256"]
  tunnel2_phase1_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase1_lifetime_seconds      = 28800
  tunnel2_phase2_dh_group_numbers      = [var.phase2_dh_group]
  tunnel2_phase2_encryption_algorithms = ["AES256-GCM-16", "AES256"]
  tunnel2_phase2_integrity_algorithms  = ["SHA2-256"]
  tunnel2_phase2_lifetime_seconds      = 3600

  tags = merge(var.tags, { "Name" = var.vpn_connection_name })
}