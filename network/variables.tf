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

variable "sub_cidr_pri" {}
variable "sub_name_pri" {}
variable "rtb_name_pri" {}
variable "sub_cidr_pub" {}
variable "sub_name_pub" {}
variable "rtb_name_pub" {}
variable "sub_az_ids" {}

variable "tgw_name" { type = string }
variable "rtb_tgw_name" { type = string }
variable "tgw_share_name" {}
variable "tgw_share_accounts" {}
variable "tgw_attach_name" {}
variable "transit_gateway_id" {}
variable "vapt_cidrs" {}
