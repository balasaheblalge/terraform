terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
  required_version = "~> 1.2.5"
 /* backend "remote" {
    organization = "EAF"

    workspaces {
      name = "eaf-ikon-network-usnc-dev"
    }
  }*/
    backend "s3" {
    bucket         = "eaf-ikon-network-usnc-dev"
    key            = "backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eaf-ikon-network-usnc-dev"
    encrypt        = true
    profile        = "default"
  }
}
