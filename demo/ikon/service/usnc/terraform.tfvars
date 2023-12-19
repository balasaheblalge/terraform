region = "us-east-1"

tags = {
  product = "ikon"
  group_name  = "gadm-iko"
}

#role_arn = "arn:aws:iam::340895064194:role/terraform-role"

resourceprefix = "na-dev-"

eks_oidc = "oidc.eks.us-east-1.amazonaws.com/id/D1E14A697A76D21CD7AB351F25FCD649" # GADM cluster

# Shared services
openvpn_cidrs = ["100.116.144.0/23"]
eks_cidrs     = ["100.116.146.0/23"]

# EC2
ec2_name_env     = "d"     # environment: p=prod; d=dev; t=test; q=quality; s=sales/demo
ec2_name_region  = "us-east-1" # region: uswaa=AWS Virginia; dewaa=AWS Frankfurt; ukwaa=AWS London
platform_abbr    = "-gadm"
ikon_type       = "t3.2xlarge"
ikon_volumesize = "10"
ssm_policy = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
]

# RDS
rds_engine_version   = "11.16"
rds_instance_type    = "db.r6i.large"
rds_db_name          = "plsql-ikon-001"
rds_master_user      = "root"
rds_param_group      = "default.postgres11"
rds_db_storage       = "25"
rds_db_max_storage   = "50"
rds_storage_type     = "gp2"
rds_backup_retention = "7"
rds_multi_az         = false
rds_db_port          = "5432"
