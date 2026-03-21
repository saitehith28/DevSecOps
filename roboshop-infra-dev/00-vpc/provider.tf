terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.37.0"
    }
  }

  backend "s3" {
    bucket  = "remote-state-tehith-aws-88s-dev" # Replace with your unique bucket name
    key     = "roboshop-dev-vpc"
    region  = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}