data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}
/*
data "terraform_remote_state" "eaf_tgw_usnc" {
  backend = "remote"
  config = {
    organization = "EAF"
    workspaces = {
      name = "eaf-tgw-usnc"
    }
  }
}*/
