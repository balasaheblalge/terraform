resource "aws_security_group" "ikon" {
  name        = "${var.resourceprefix}sg-ikon"
  description = "Allow traffic to ikon instance"
  vpc_id      = data.terraform_remote_state.network_usnc.outputs.vpc_id

  ingress {
    description = "SSH from OpenVPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.openvpn_cidrs
  }

  ingress {
    description = "HTTPS from OpenVPN"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.openvpn_cidrs
  }

  ingress {
    description = "HTTPS from EKS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.eks_cidrs
  }

  egress {
    description = "Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
