resource "aws_db_subnet_group" "sg-rds" {
  name       = "${var.resourceprefix}rds-subg"
  subnet_ids = [data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[0], data.terraform_remote_state.apim-network.outputs.subnet_ids_pri[1]]

  tags = merge({ "Name" = "${var.resourceprefix}rds-subg" }, var.tags)
}

resource "aws_db_instance" "postgresql" {
  engine               = "postgres"
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_type
  db_name              = var.rds_db_name
  identifier           = "${var.resourceprefix}postgresql"
  username             = var.rds_master_user
  password             = data.aws_secretsmanager_secret_version.rds_password.secret_string
  parameter_group_name = var.rds_param_group

  allocated_storage = var.rds_db_storage
  #  max_allocated_storage = var.rds_db_max_storage   #DEV env not require this value as storage autoscaling is disabled
  storage_type      = var.rds_storage_type
  storage_encrypted = true

  skip_final_snapshot      = true
  delete_automated_backups = false
  copy_tags_to_snapshot    = true
  deletion_protection      = false
  backup_retention_period  = var.rds_backup_retention

  multi_az               = var.rds_multi_az
  port                   = var.rds_db_port
  db_subnet_group_name   = aws_db_subnet_group.sg-rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled = true
  performance_insights_retention_period = var.performance_insights_retention_period

  tags = merge({ "Name" = "${var.resourceprefix}postgresql" }, var.tags)
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "postgresql-password"
  tags = merge({ "Name" = "${var.resourceprefix}rds_pass" }, var.tags)
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.rds_password.result
}

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id  = aws_secretsmanager_secret.rds_password.id
  depends_on = [aws_secretsmanager_secret_version.rds_password]
}
