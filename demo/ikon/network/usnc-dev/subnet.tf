resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = "${var.resourceprefix}${var.rtb_name}" }, var.tags)
}

resource "aws_route_table_association" "this" {
  count = length(var.sub_cidr)

  subnet_id      = element(aws_subnet.this.*.id, count.index)
  route_table_id = aws_route_table.this.id
}

resource "aws_route" "this_out" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.this]


}

resource "aws_subnet" "this" {
  count = length(var.sub_cidr)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.sub_cidr[count.index]
  #  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  availability_zone_id = element(var.sub_az_ids, count.index)

  tags = merge({ "Name" = "${var.resourceprefix}${var.sub_name}-${element(split("-", element(data.aws_availability_zones.available.names, count.index)), 2)}" }, var.tags)
}
