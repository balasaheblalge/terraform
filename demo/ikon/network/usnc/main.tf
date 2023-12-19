provider "aws" {
    region  = var.region
   /* assume_role {
      role_arn     = var.role_arn
    }*/
}
/*
provider "aws" {
    alias = "core"
    region = var.region
    assume_role {
    }
}*/
