variable "region" {}

variable "tags" {
  type = map(any)
}

#variable "role_arn" {}

variable "resourceprefix" { type = string }

#variable "openvpn_cidrs" {}

variable "eks_oidc" {}

variable "apim_port" {}
#variable "ipaas_prod_cidrs" {}
#variable "ipaas_test_cidrs" {}
variable "pl_vpce_name" {}
variable "ct_cidr" {}
variable "capgemini_public_cidrs" {}
#variable "route53_zone_name" {}
variable "vpn_endpoint_cidrs" {}
variable "eks_cidrs" {}

variable "rds_engine_version" {}
variable "rds_instance_type" {}
variable "rds_db_name" {}
variable "rds_param_group" {}
variable "rds_db_storage" {}
variable "rds_db_max_storage" {}
variable "rds_storage_type" {}
variable "rds_db_port" {}
variable "rds_master_user" {}
variable "rds_multi_az" {}
variable "rds_backup_retention" {}
variable "apim_fqdn" {}
variable "route53_apim_zone_name" {}
variable "efs_name" {}
variable "enabled_cloudwatch_logs_exports" {
  type = set(string)
}
variable "performance_insights_retention_period" {}

variable "mq_engine_version" {}
variable "mq_instance_type" {}
variable "mq_deployment_mode" {}
variable "rabbitmq_port" {}
variable "rabbitmq_port2" {}
variable "rabbitmq_port3" {}
variable "rabbitmq_port4" {}
variable "vapt_cidrs" {}
variable "capgemini_cidrs" {}
variable "fortive_cidrs" {}
variable "awsvpn_cidrs" {}
variable "ipaas_cidrs" {}
variable "email_identity" {
  type = string
  description = "The email address that emails will be sent from, a verification message from aws will be sent here."
}
variable "allowed_account_ids" {
  type = list
  description = "A list of account ids that are allowed to assume the ses email role"
}
