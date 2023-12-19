variable "region" {}

variable "tags" {
  type = map(any)
}

#variable "role_arn" {}

variable "resourceprefix" { type = string }

variable "openvpn_cidrs" {}
variable "eks_cidrs" {}

variable "ec2_name_env" {}
variable "ec2_name_region" {}
variable "platform_abbr" {}
variable "ikon_type" {}
variable "ikon_volumesize" {}
variable "ssm_policy" {}

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

variable "eks_oidc" {}
