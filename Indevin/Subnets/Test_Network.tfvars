
region                = "ap-southeast-2"
profile               = "indevin_test_network"
vpc_id             = "vpc-05bbd24f3a3d4e4d4"


subnet_private_names = [
  "ind_test_WL_VillaMariaWebsite_snet_2a",
  "ind_test_WL_VillaMariaWebsite_snet_2b"
]
subnet_private_prefixes = [
  "10.250.3.0/24",
  "10.250.131.0/24"
]
rt_private_names = [
  "ind_test_WL_VillaMariaWebsite_rt_2a",
  "ind_test_WL_VillaMariaWebsite_rt_2b"
]
availability_zones = 2

transit_gateway_id = "tgw-022b53fee4b0e345b"
nat_gateway_id = [
  "nat-01d022f0dac962196", //available zone 2a
  "nat-0593fdc4fc782ba10" //available zone 2b
]

tags = {
  "application" = "VPC network",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "test"
}