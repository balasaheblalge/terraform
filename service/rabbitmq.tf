/*resource "aws_mq_broker" "rabbitmq" {
  depends_on  = [aws_secretsmanager_secret_version.mq_password]
  broker_name = "rabbitmq"

  engine_type         = "RabbitMQ"
  engine_version      = var.mq_engine_version
  host_instance_type  = var.mq_instance_type
  security_groups     = [aws_security_group.rabbitmq.id]
  deployment_mode     = var.mq_deployment_mode
  publicly_accessible = false
  subnet_ids          = [data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[0]]

  user {
    username = "rabbitmq"
    password = data.aws_secretsmanager_secret_version.mq_password.secret_string
  }
  tags = merge({ "Name" = "${var.resourceprefix}rabbitmq" }, var.tags)
}
*/ # (password of this rabbitmq is in use)

resource "aws_security_group" "rabbitmq" {
  name        = "${var.resourceprefix}rabbitmq"
  description = "Enables access to RabbitMQ service"
  vpc_id      = data.terraform_remote_state.apim-network.outputs.vpc_id

  ingress {
    description = "Enable all traffic from VM security group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [
      aws_security_group.apim.id
    ]
  }

  ingress {
    description = "Enabling RabbitMQ port from EKS"
    from_port   = var.rabbitmq_port
    to_port     = var.rabbitmq_port
    protocol    = "tcp"
    cidr_blocks = var.eks_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port
    to_port     = var.rabbitmq_port
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port2
    to_port     = var.rabbitmq_port2
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port3
    to_port     = var.rabbitmq_port3
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port4
    to_port     = var.rabbitmq_port4
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  /*  ingress {
    description = "Enabling RabbitMQ console from VPN Endpoint"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }*/

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ "Name" = "${var.resourceprefix}rabbitmq" }, var.tags)
}

resource "random_password" "mq_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "mq_password" {
  name = "rabbitmq-password"
  tags = merge({ "Name" = "${var.resourceprefix}mq_pass" }, var.tags)
}

resource "aws_secretsmanager_secret_version" "mq_password" {
  secret_id     = aws_secretsmanager_secret.mq_password.id
  secret_string = random_password.mq_password.result
}

data "aws_secretsmanager_secret_version" "mq_password" {
  secret_id  = aws_secretsmanager_secret.mq_password.id
  depends_on = [aws_secretsmanager_secret_version.mq_password]
}

resource "aws_mq_broker" "rabbitmq1" {
  depends_on  = [aws_secretsmanager_secret_version.mq_password]
  broker_name = "rabbitmq1"

  engine_type         = "RabbitMQ"
  engine_version      = var.mq_engine_version
  host_instance_type  = "mq.t3.micro"
  security_groups     = [aws_security_group.rabbitmq1.id]
  deployment_mode     = var.mq_deployment_mode
  publicly_accessible = false
  subnet_ids          = [data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[1]]

  user {
    username = "rabbitmq"
    password = data.aws_secretsmanager_secret_version.mq_password.secret_string
  }
  tags = merge({ "Name" = "${var.resourceprefix}rabbitmq1" }, var.tags)
}

resource "aws_security_group" "rabbitmq1" {
  name        = "${var.resourceprefix}rabbitmq1"
  description = "Enables access to RabbitMQ service"
  vpc_id      = data.terraform_remote_state.apim-network.outputs.vpc_id

  ingress {
    description = "Enable all traffic from VM security group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [
      aws_security_group.apim.id
    ]
  }

  ingress {
    description = "Enabling RabbitMQ port from EKS"
    from_port   = var.rabbitmq_port
    to_port     = var.rabbitmq_port
    protocol    = "tcp"
    cidr_blocks = var.eks_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port
    to_port     = var.rabbitmq_port
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port2
    to_port     = var.rabbitmq_port2
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port3
    to_port     = var.rabbitmq_port3
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  ingress {
    description = "Enabling RabbitMQ port from Vpn Endpoint CIDR"
    from_port   = var.rabbitmq_port4
    to_port     = var.rabbitmq_port4
    protocol    = "tcp"
    cidr_blocks = var.vpn_endpoint_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ "Name" = "${var.resourceprefix}rabbitmq1" }, var.tags)
}

resource "random_password" "mq_password2" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "mq_password2" {
  name = "rabbitmq-password2"
  tags = merge({ "Name" = "${var.resourceprefix}mq_pass2" }, var.tags)
}

resource "aws_secretsmanager_secret_version" "mq_password2" {
  secret_id     = aws_secretsmanager_secret.mq_password2.id
  secret_string = random_password.mq_password2.result
}

data "aws_secretsmanager_secret_version" "mq_password2" {
  secret_id  = aws_secretsmanager_secret.mq_password2.id
  depends_on = [aws_secretsmanager_secret_version.mq_password2]
}

