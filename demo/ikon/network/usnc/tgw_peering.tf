/*# Request
resource "aws_ec2_transit_gateway_peering_attachment" "core_services" {
  provider = aws.core
  peer_account_id	  = data.aws_caller_identity.current.id
  peer_region             = var.region
  peer_transit_gateway_id = aws_ec2_transit_gateway.this.id
  transit_gateway_id      = aws_ec2_transit_gateway.this.id 
   #data.terraform_remote_state.eaf_tgw_usnc.outputs.tgw_id

  tags = merge({ "Name" = "${var.resourceprefix}peer" }, var.tags)
}

# Accept
# Need to use additional data resource to get around bug https://github.com/hashicorp/terraform-provider-aws/issues/24677
data "aws_ec2_transit_gateway_peering_attachment" "fix" {
	depends_on = [aws_ec2_transit_gateway_peering_attachment.core_services]
	filter {
		name   = "transit-gateway-id"
		values = [aws_ec2_transit_gateway.this.id]
	}
        filter {
                name   = "state"
                values = ["pendingAcceptance","available"]
        }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "this" {
  transit_gateway_attachment_id = data.aws_ec2_transit_gateway_peering_attachment.fix.id

  tags = merge({ "Name" = "${var.resourceprefix}peer" }, var.tags)
}

# Associate route table with peering attachment in core services account
resource "aws_ec2_transit_gateway_route_table_association" "peering" {
  provider = aws.core
  transit_gateway_route_table_id = lookup(data.terraform_remote_state.eaf_tgw_usnc.outputs.rtb_ids, var.env, "")
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.core_services.id
}

# Create static routes in both directions for peering connection
resource "aws_ec2_transit_gateway_route" "cs_out" {
  depends_on = [aws_ec2_transit_gateway_peering_attachment.core_services, aws_ec2_transit_gateway_peering_attachment_accepter.this]
  provider = aws.core
  destination_cidr_block         = var.vpc_cidr
  blackhole                      = false
  transit_gateway_route_table_id = lookup(data.terraform_remote_state.eaf_tgw_usnc.outputs.rtb_ids, var.env, "")
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.core_services.id
}
resource "aws_ec2_transit_gateway_route" "core_out" {
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment.core_services, aws_ec2_transit_gateway_peering_attachment_accepter.this]
  provider                       = aws.core
  destination_cidr_block         = var.vpc_cidr
  blackhole                      = false
  transit_gateway_route_table_id = lookup(data.terraform_remote_state.eaf_tgw_usnc.outputs.rtb_ids, "core", "")
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.core_services.id
}

resource "aws_ec2_transit_gateway_route" "to_core" {
  depends_on = [aws_ec2_transit_gateway_peering_attachment.core_services, aws_ec2_transit_gateway_peering_attachment_accepter.this]
  destination_cidr_block         = "0.0.0.0/0"
  blackhole                      = false
  transit_gateway_route_table_id = aws_ec2_transit_gateway.this.association_default_route_table_id
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_peering_attachment.fix.id
}
*/