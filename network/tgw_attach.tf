resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  # List of subnets is used to list all AZs in use NOT all subnets per se
  subnet_ids = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = aws_vpc.this.id

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = merge({ "Name" = "${var.resourceprefix}${var.tgw_attach_name}" }, var.tags)
}
