resource "aws_security_group" "rds" {
  name        = "${var.resourceprefix}sg-rds"
  description = "Enabled PostgreSQL port access to RDS instances"
  vpc_id      = data.terraform_remote_state.network_usnc.outputs.vpc_id

  ingress {
    description     = "Enabling PostgreSQL port from whole subnets"
    from_port       = var.rds_db_port
    to_port         = var.rds_db_port
    protocol        = "tcp"
    cidr_blocks = data.terraform_remote_state.network_usnc.outputs.subnet_cidrs
  }

  ingress {
    description     = "Postgres from OpenVPN"
    from_port       = var.rds_db_port
    to_port         = var.rds_db_port
    protocol        = "tcp"
    cidr_blocks     = var.openvpn_cidrs
  }

  ingress {
    description     = "Postgres from EKS"
    from_port       = var.rds_db_port
    to_port         = var.rds_db_port
    protocol        = "tcp"
    cidr_blocks     = var.eks_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ "Name" = "${var.resourceprefix}sg-rds" }, var.tags)
}
