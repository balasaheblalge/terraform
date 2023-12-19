provider "aws" {
  region = var.region
  /*    assume_role {
      role_arn     = var.role_arn
    }*/
}

# module "sg_ccp_linux" {
#   source = "../../../modules/sg_ccp_linux"

#   resourceprefix = var.resourceprefix
#   vpc_id = data.terraform_remote_state.network_usnc.outputs.vpc_id

#   tags = var.tags
# }