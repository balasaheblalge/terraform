resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = [
    aws_route_table.private.id
  ]

  tags = merge({ "Name" = "${var.resourceprefix}${var.s3vpcendpoint_name}" }, var.tags)
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}ec2" }, var.tags)
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}ec2messages" }, var.tags)
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}ssm" }, var.tags)
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}ssmmessages" }, var.tags)
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}kms" }, var.tags)
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]

  tags = merge({ "Name" = "${var.resourceprefix}logs" }, var.tags)
}
