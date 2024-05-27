profile_first      = "indevin_prod_network"
profile_second     = "indevin_test_network"
region             = "ap-southeast-2"
transit_gw_id      = "tgw-022b53fee4b0e345b"
availability_zones = 2

vpc_first_id = "value"

subnet_first_names = [
  "transit_gw_apse2-az3",
"transit_gw_apse2-az1"]

subnet_first_cidr_blocks = [
  "",
  ""
]

vpc_second_id = "value"
subnet_second_names = [
  "transit_gw_apse2-az3",
"transit_gw_apse2-az1"]

subnet_second_cidr_blocks = [
  "",
  ""
]

tags = {
  "application" = "S2S VPN",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "test"
}

