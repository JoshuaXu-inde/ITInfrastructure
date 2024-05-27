region                = "ap-southeast-2"
profile               = "indevin_prod_network"
transit_gateway_id    = "tgw-022b53fee4b0e345b"
bgp_asn               = "65111"
customer_gateway_name = "fairhall"
customer_gw_ip        = "203.97.219.82"
vpn_connection_name   = "S2SVPN_to_fairhall"
tunnel1_inside_cidr   = "169.254.100.0/30"
tunnel2_inside_cidr   = "169.254.100.4/30"
tunnel_preshared_key  = "Qsfupx7X4GumGaUVaQ8g"

tags = {
  "application" = "S2S VPN",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "prod"
}