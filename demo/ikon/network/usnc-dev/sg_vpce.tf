resource "aws_security_group" "vpce" {
  name        = "${var.resourceprefix}vpce"
  description = "Allow VPC endpoint traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Inbound from VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.vpc_cidr
  }

  ingress {
    description = "Connectivity from SAM"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.vapt_cidrs
  }

  egress {
    description = "Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ "Name" = "${var.resourceprefix}vpce-sg" }, var.tags)
}
