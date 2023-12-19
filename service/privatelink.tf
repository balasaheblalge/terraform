resource "aws_security_group" "apim_pl" {
  vpc_id = data.terraform_remote_state.apim-network.outputs.vpc_id

  ingress {
    description     = "Allow ALB traffic to APIM PL endpoints"
    from_port       = var.apim_port
    to_port         = var.apim_port
    protocol        = "tcp"
    security_groups = [aws_security_group.apim_alb.id]
  }
}

resource "aws_vpc_endpoint" "apim_pl" {
  vpc_id              = data.terraform_remote_state.apim-network.outputs.vpc_id
  subnet_ids          = data.terraform_remote_state.apim-network.outputs.subnet_ids_pri
  service_name        = var.pl_vpce_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.apim_pl.id]
  private_dns_enabled = false
}
