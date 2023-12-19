variable "region" {}

variable "env" {}

variable "tags" {
  type = map(any)
}

#variable "role_arn" {}
#variable "role_arn_core" {}

variable "resourceprefix" { type = string }

variable "vpc_cidr" {}
variable "vpc_name" {}
variable "s3vpcendpoint_name" {}
variable "vpcflowlog_name" {}
variable "rtb_vpc_name" {}
variable "nacl_name" {}
#variable "aws_route53_zone" {}

variable "sub_cidr" {}
variable "sub_az_ids" {}
variable "sub_name" {}
variable "rtb_name" {}

variable "tgw_name" { type = string }
variable "rtb_tgw_name" { type = string }
variable "tgw_share_name" {}
variable "tgw_share_accounts" {}
variable "tgw_attach_name" {}
variable "transit_gateway_id" {}
variable "vapt_cidrs" {}
