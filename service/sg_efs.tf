resource "aws_security_group" "efs" {
  name        = "${var.resourceprefix}sg-efs"
  description = "Allow traffic to apim_efs from apim instances"
  vpc_id      = data.terraform_remote_state.apim-network.outputs.vpc_id

  ingress {
    description     = "Allow NFS traffic out from EC2 to mount target"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.apim.id]
  }

  ingress {
    description = "EFS traffic from EKS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.eks_cidrs
  }

  ingress {
    description = "Connectivity from SAM"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.vapt_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ "Name" = "${var.resourceprefix}sg-efs" }, var.tags)
}