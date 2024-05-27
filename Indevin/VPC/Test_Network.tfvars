region  = "ap-southeast-2"
profile = "indevin_test_network"

vpc_name              = "ind_test"
vpc_address_space     = "10.250.0.0/16"
internet_gateway_name = "ind_test_igw"
transit_gateway_id    = "tgw-022b53fee4b0e345b"
natgw_ip_names = [
  "ind_test_pip_natgw_2a",
  "ind_test_pip_natgw_2b"
]
natgw_names = [
  "ind_test_natgw_2a",
  "ind_test_natgw_2b"
]

subnet_public_names = [
  "ind_test_public_subnet_2a",
  "ind_test_public_subnet_2b"
]
subnet_public_prefixes = [
  "10.250.0.0/24",
  "10.250.128.0/24"

]
subnet_private_names = [
  "ind_test_tgw_subnet_2a",
  "ind_test_tgw_subnet_2b"
]
subnet_private_prefixes = [
  "10.250.1.0/24",
  "10.250.129.0/24"
]
rt_public_names = [
  "ind_test_public_rt_2a",
  "ind_test_public_rt_2b"
]
rt_private_names = [
  "ind_test_tgw_rt_2a",
  "ind_test_tgw_rt_2b"
]
availability_zones = 2

tags = {
  "application" = "VPC",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "test"
}