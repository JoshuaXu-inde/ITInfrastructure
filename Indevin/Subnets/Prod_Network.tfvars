
region                = "ap-southeast-2"
profile               = "indevin_prod_network"
vpc_id             = "vpc-0d452faad11918027"


subnet_private_names = [
  "ind_prod_WL_Quicksight_snet_2a",
  "ind_prod_WL_Quicksight_snet_2b"
]
subnet_private_prefixes = [
  "10.199.5.0/24",
  "10.199.133.0/24"
]
rt_private_names = [
  "ind_prod_WL_Quicksight_rt_2a",
  "ind_prod_WL_Quicksight_rt_2b"
]
availability_zones = 2

transit_gateway_id = "tgw-022b53fee4b0e345b"
nat_gateway_id = [
  "nat-016746da891292676", //available zone 2a
  "nat-091b168d3c84c88fe" //available zone 2b
]

tags = {
  "application" = "VPC network",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "prod"
}