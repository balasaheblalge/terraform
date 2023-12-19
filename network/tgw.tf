/*resource "aws_ec2_transit_gateway" "this" {
  #  amazon_side_asn = var.amazon_side_asn
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  #  vpn_ecmp_support = "enable"

  tags = merge({ "Name" = "${var.resourceprefix}${var.tgw_name}" }, var.tags)
}*/
