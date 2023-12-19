resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = "${var.resourceprefix}${var.rtb_name_pub}" }, var.tags)
}

resource "aws_route_table_association" "public" {
  count = length(var.sub_cidr_pub)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_out" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "public" {
  count = length(var.sub_cidr_pub)

  vpc_id               = aws_vpc.this.id
  cidr_block           = var.sub_cidr_pub[count.index]
  availability_zone_id = element(var.sub_az_ids, count.index)

  tags = merge({ "Name" = "${var.resourceprefix}${var.sub_name_pub}-${element(split("-", element(data.aws_availability_zones.available.names, count.index)), 2)}" }, var.tags)
}
