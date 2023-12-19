terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
  required_version = "~> 1.2.5"

  backend "s3" {
    bucket         = "eaf-ikon-sandpit"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eaf-dynamodb-ikon"
    encrypt        = true
    profile        = "default"
  }
}
