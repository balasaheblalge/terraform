/*data "terraform_remote_state" "network_usnc" {
  backend = "remote"
  config = {
    organization = "EAF"
    workspaces = {
      name = "eaf-ikon-network-usnc"
    }
  }
}*/

data "terraform_remote_state" "network_usnc" {
  backend = "s3"
   config = {
    bucket = "eaf-ikon-network-usnc-dev"
    key    = "backend/terraform.tfstate"
    region = var.region
  }
}
data "aws_caller_identity" "current" {}

data "tls_certificate" "eks_oidc" {
  url = "https://${var.eks_oidc}"
}
