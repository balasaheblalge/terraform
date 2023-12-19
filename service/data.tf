/*data "terraform_remote_state" "network_usnc" {
  backend = "remote"
  config = {
    organization = "EAF"
    workspaces = {
      name = "eaf-apim-network-usnc-dev"
    }
  }
}*/

data "terraform_remote_state" "apim-network" {
  backend = "s3"
  config = {
    bucket = "eaf-apim-sandpit"
    key    = "network/terraform.tfstate"
    region = var.region
  }
}

data "aws_caller_identity" "current" {}

data "tls_certificate" "eks_oidc" {
  url = "https://${var.eks_oidc}"
}


data "aws_elb_service_account" "main" {}