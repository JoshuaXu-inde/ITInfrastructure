
region                = "ap-southeast-2"
profile               = "indevin_prod_network"
vpc_name              = "vpc_prod"
vpc_address_space     = "10.199.0.0/16"
internet_gateway_name = "vpc_prod_igw"
subnet_public_names = [
  "vpc_prod_public_subnet_2a",
  "vpc_prod_public_subnet_2b"
]
subnet_public_prefixes = [
  "10.199.0.0/24",
  "10.199.128.0/24"
]
subnet_private_names = [
  "vpc_prod_private_subnet_2a",
  "vpc_prod_private_subnet_2b"
]
subnet_private_prefixes = [
  "10.199.1.0/24",
  "10.199.129.0/24"
]
rt_public_names = [
  "vpc_prod_public_rt_2a",
  "vpc_prod_public_rt_2b"
]
rt_private_names = [
  "vpc_prod_private_rt_2a",
  "vpc_prod_private_rt_2b"
]
availability_zones = 2

tags = {
  "application" = "VPC network",
  "creator"     = "joshua.xu@inde.nz"
  "managedBy"   = "juan.rossi@indevin.com"
  "environment" = "prod"
}