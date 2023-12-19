resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = "${var.resourceprefix}${var.rtb_name_pri}" }, var.tags)
}

resource "aws_route_table_association" "private" {
  count = length(var.sub_cidr_pri)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_out" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_subnet" "private" {
  count = length(var.sub_cidr_pri)

  vpc_id               = aws_vpc.this.id
  cidr_block           = var.sub_cidr_pri[count.index]
  availability_zone_id = element(var.sub_az_ids, count.index)

  tags = merge({ "Name" = "${var.resourceprefix}${var.sub_name_pri}-${element(split("-", element(data.aws_availability_zones.available.names, count.index)), 2)}" }, var.tags)
}
