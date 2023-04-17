terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = ">= 1.30.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
