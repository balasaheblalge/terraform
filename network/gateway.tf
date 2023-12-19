resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = "${var.resourceprefix}igw" }, var.tags)
}
