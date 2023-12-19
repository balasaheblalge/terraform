region = "us-east-1"

env = "devt"

tags = {
  product = "apim"
}

#role_arn      = "arn:aws:iam::337237144316:role/terraform-role"
#role_arn_core = "arn:aws:iam::192320433650:role/terraform_role"

resourceprefix = "na-dev-"

vpc_name           = "vpc-apim-001"
vpcflowlog_name    = "vpcflow-apim-001"
s3vpcendpoint_name = "vpcs3ep-apim-001"
rtb_vpc_name       = "rtb-vpc-apim-001"
nacl_name          = "nacl-apim-001"
vpc_cidr           = "100.110.2.128/26"
#aws_route53_zone   = "Z0705669PPSOBKEX56AQ"

sub_cidr_pub = ["100.110.2.128/28", "100.110.2.144/28"]
sub_name_pub = "sub-pub"
rtb_name_pub = "rtb-pub"
sub_cidr_pri = ["100.110.2.160/28", "100.110.2.176/28"]
sub_name_pri = "sub-pri"
rtb_name_pri = "rtb-pri"
sub_az_ids   = ["use1-az6", "use1-az4", "use1-az2"] # Need to use specific AZ IDs to match use of PrivateLink by Kubernetes cluster NLB integration

tgw_name       = "tgw-apim-001"
rtb_tgw_name   = "rt-tgw-apim-001"
tgw_share_name = "tgw-share-apim-001"
tgw_share_accounts = [
]
tgw_attach_name = "tgw-attach-apim-001"
transit_gateway_id = "tgw-0b5b50f5b0a18306a"
vapt_cidrs         = ["100.110.8.158/32", "100.110.8.151/32"] # VAPT machines' IPs
