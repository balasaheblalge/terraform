region = "us-east-1"

tags = {
  product    = "apim"
  owner = "product-team"
}

#role_arn = "arn:aws:iam::252873188186:role/terraform-role"

resourceprefix = "na-dev-"

eks_oidc = "oidc.eks.us-east-1.amazonaws.com/id/D1E14A697A76D21CD7AB351F25FCD649" # GADM cluster

# Shared services
#openvpn_cidrs = ["100.116.144.0/23"]

# ALB
apim_port = 443
#ipaas_prod_cidrs = ["3.233.127.27/32", "18.205.86.239/32", "3.208.156.244/32"]
#ipaas_test_cidrs = ["3.221.228.198/32", "100.26.90.36/32", "3.208.97.98/32"]
ct_cidr = ["52.203.136.198/32", "54.173.72.120/32"] #Taken from usnc, need to change
capgemini_public_cidrs = [
  "202.60.62.0/23", "202.60.60.0/24", "202.91.136.0/24",                                                  #Bangalore
  "202.91.140.0/23",                                                                                      #Chennai
  "123.242.240.0/22", "123.242.240.52/32", "123.242.240.51/32", "123.242.242.16/32", "123.242.242.17/32", #Hyderabad
  "203.191.34.0/23", "203.189.180.0/22", "202.61.8.0/22", "203.191.35.62/32",                             #Mumbai
  "120.29.232.0/24",                                                                                      #Noida
  "123.242.248.0/22", "203.189.176.0/24",                                                                #Pune
]
pl_vpce_name      = "com.amazonaws.vpce.us-east-1.vpce-svc-0f8c8798b426a7f24"
route53_apim_zone_name = "gadm-apim-sandpit.na.eaf.capgemini.com"
vpn_endpoint_cidrs = ["100.110.6.0/24", "100.110.5.0/24", "100.110.4.0/24"]
eks_cidrs          = ["100.110.0.0/23","100.112.4.0/23", "100.112.6.0/23"]
vapt_cidrs         = ["100.110.8.158/32", "100.110.8.151/32"] # VAPT machines' IPs

# RDS
rds_engine_version   = "11.19"
rds_instance_type    = "db.r6i.large"
rds_db_name          = "postgresql"
rds_master_user      = "apim_devt"
rds_param_group      = "default.postgres11"
rds_db_storage       = "50"
rds_db_max_storage   = "100"
rds_storage_type     = "gp2"
rds_backup_retention = "7"
rds_multi_az         = false
rds_db_port          = "5432"
#apim_fqdn = "apimwapp.gadm-apim-sandpit.na.eafcore.com" 
apim_fqdn = "apimwapp.gadm-apim-sandpit.na.eaf.capgemini.com"
#route53_apim_zone_name = "gadm-apim-sandpit.na.eafcore.com"

#EFS
efs_name = "efs01"
enabled_cloudwatch_logs_exports = ["postgresql","upgrade"]
performance_insights_retention_period = "7"

#RabbitMQ
mq_engine_version  = "3.9.16"
mq_instance_type   = "mq.m5.large"
mq_deployment_mode = "SINGLE_INSTANCE"
rabbitmq_port      = 5671
rabbitmq_port2      = 5672
rabbitmq_port3      = 15671
rabbitmq_port4      = 15672

email_identity = "ashwini.a.krishna@capgemini.com"
allowed_account_ids = ["171186227351"]
