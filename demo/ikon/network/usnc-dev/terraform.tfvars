region = "us-east-1"

env = "devt"

tags = {
  product    = "ikon"
  group_name = "gadm-ikon"
}

#role_arn      = "arn:aws:iam::546285825991:role/terraform-role"
#role_arn_core = "arn:aws:iam::192320433650:role/terraform_role"

resourceprefix = "eaf-ikon-usnc-devt-"

vpc_name           = "vpc-ikon-001"
vpcflowlog_name    = "vpcflowlog-ikon-001"
s3vpcendpoint_name = "vpcs3ep-ikon-001"
rtb_vpc_name       = "rt-vpc-ikon-001"
nacl_name          = "nacl-ikon-001"
vpc_cidr           = ["100.110.3.192/26", "172.16.0.0/22"]
#aws_route53_zone   = "Z0705669PPSOBKEX56AQ"

sub_cidr   = ["100.110.3.192/27", "100.110.3.224/27"]
sub_az_ids = ["use1-az6", "use1-az1", "use1-az2"] # Need to use specific AZ IDs to match use of PrivateLink by Kubernetes cluster NLB integration
sub_name   = "sub-ikon-001"
rtb_name   = "rt-ikon-001"

tgw_name       = "tgw-ikon-001"
rtb_tgw_name   = "rt-tgw-ikon-001"
tgw_share_name = "tgw-share-ikon-001"
tgw_share_accounts = [
]
tgw_attach_name    = "tgw-attach-ikon-001"
transit_gateway_id = "tgw-0d46ad36ab81781e9"
vapt_cidrs         = ["100.110.8.158/32", "100.110.8.151/32"] # VAPT machines' IPs
