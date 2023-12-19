resource "aws_security_group" "apim_alb" {
  name        = "${var.resourceprefix}apim-alb-sg"
  description = "Enables traffic to APIM PL endpoints via ALB"
  vpc_id      = data.terraform_remote_state.apim-network.outputs.vpc_id

/*  ingress {
    description = "Inbound APIM traffic from IPaaS"
    from_port   = var.apim_port
    to_port     = var.apim_port
    protocol    = "tcp"
    cidr_blocks = concat(var.ct_cidr, var.capgemini_public_cidrs)
  }

*/

  ingress {
    description = "Connectivity from EAF components"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

  tags = merge({ "Name" = "${var.resourceprefix}apim-alb-sg" }, var.tags)
}
