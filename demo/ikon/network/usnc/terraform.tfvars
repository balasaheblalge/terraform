region = "us-east-1"

env = "dev"

tags = {
  product     = "ikon"
  group_name  = "gadm-iko"
}

#role_arn = "arn:aws:iam::340895064194:role/terraform-role"
#role_arn_core = "arn:aws:iam::192320433650:role/terraform_role"

resourceprefix = "na-dev-"

vpc_name           = "vpc-ikon-001"
vpcflowlog_name    = "vpcflow-ikon-001"
s3vpcendpoint_name = "vpcs3ep-ikon-001"
rtb_vpc_name       = "rt-vpc-ikon-001"

nacl_name          = "nacl-ikon-001"
vpc_cidr           = "100.116.159.0/25"
aws_route53_zone   = "Z0705669PPSOBKEX56AQ"

sub_cidr = ["100.116.159.0/26", "100.116.159.64/26"]
sub_az_ids = ["use1-az6", "use1-az1", "use1-az2"] # Need to use specific AZ IDs to match use of PrivateLink by Kubernetes cluster NLB integration
sub_name = "pvsub-ikon-001"

rtb_name = "pv-rt-ikon-001"

tgw_name     = "tgw-ikon-001"
rtb_tgw_name = "rt-tgw-ikon-001"
tgw_share_name = "tgw-share-ikon-001"
tgw_share_accounts = [
]
tgw_attach_name = "tgw-attach-ikon-001"
