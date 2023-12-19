data "terraform_remote_state" "usnc-dev" {
  backend = "s3"
  config = {
    bucket = "eaf-ikon-sandpit"
    key    = "network/terraform.tfstate"
    region = var.region
  }
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_iam_instance_profile" "session-manager-profile"{
  name = var.session-manager-role-name 
}
data "aws_iam_policy" "cloudWatchagentserverpolicy" { 
  name = "CloudWatchAgentServerPolicy" 
  }
data "aws_iam_policy" "amazonssmmanagedinstancecore" { 
  name = "AmazonSSMManagedInstanceCore" 
  }
data "aws_iam_policy" "amazonssmdirectoryserviceaccess" { 
  name = "AmazonSSMDirectoryServiceAccess" 
  }
data "aws_iam_policy" "ec2fullaccess" { 
  name = "AmazonEC2FullAccess" 
  }
data "aws_iam_policy" "amazonssmfullaccess" { 
  name = "AmazonSSMFullAccess" 
  }
data "tls_certificate" "tooling_eks_oidc" {
  url = "https://${var.tooling_eks_oidc}"
}
data "aws_iam_policy" "s3fullaccess" { 
  name = "AmazonS3FullAccess" 
  }
data "aws_iam_policy" "session-manager-policyy" { 
  name = "session-manager-policy" 
  }