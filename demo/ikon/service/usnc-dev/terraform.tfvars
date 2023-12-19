region = "us-east-1"

env = "dev"

tags = {
  product    = "ikon"
  group_name = "gadm-ikon"
}

#role_arn = "arn:aws:iam::546285825991:role/terraform-role"

resourceprefix = "na-dev-"

eks_oidc = "oidc.eks.us-east-1.amazonaws.com/id/295CCBF24E4D00111CAA42E7A9936735" # GADM cluster, taken from eks sandpit cluster
tooling_eks_oidc = "oidc.eks.eu-central-1.amazonaws.com/id/09E395DCA46D47C97775A0F3A0C908D1" # eks tooling clutser oidc

# Shared services
vpn_endpoint_cidrs = ["100.110.6.0/24", "100.110.5.0/24", "100.110.4.0/24", "100.110.3.0/24","100.112.0.0/24", "100.112.2.0/24", "100.112.1.0/24"]
eks_cidrs          = ["100.110.0.0/23", "100.112.4.0/23", "100.112.6.0/23"] # taken from eks sandpit cluster "100.112.4.0/23", "100.112.6.0/23 belongs to EKS Tooling"

# EC2
ec2_name_env    = "d"     # environment: p=prod; d=dev; t=test; q=quality; s=sales/demo
ec2_name_region = "uswaa" # region: uswaa=AWS Virginia; dewaa=AWS Frankfurt; ukwaa=AWS London
platform_abbr   = "-nc-devt"
ikon_type       = "t3.2xlarge"
ikon_volumesize = "50"
ssm_policy = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
]

# RDS
rds_engine_version   = "11.19"
rds_instance_type    = "db.r6i.large"
rds_db_name          = "postgresql"
rds_master_user      = "ikon_devt"
rds_param_group      = "default.postgres11"
rds_db_storage       = "25"
rds_db_max_storage   = "50"
rds_storage_type     = "gp2"
rds_backup_retention = "7"
rds_multi_az         = false
rds_db_port          = "5432"

#EFS
efs_name = "efs01"

session-manager-role-name = "ec2-instance-access"
enabled_cloudwatch_logs_exports = ["postgresql","upgrade"]
performance_insights_retention_period = "7"
vapt_cidrs         = ["100.110.8.158/32", "100.110.8.151/32"] # VAPT machines' IPs
