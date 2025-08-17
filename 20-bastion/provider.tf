terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.99.0"
    }
  }
  backend "s3" {
  bucket = "harsha84-aws-eks"
  key    = "roboshop-dev-bastion"
  region = "us-east-1"
  #dynamodb_table = "harsha84-remote-state"
  encrypt = true
  use_lockfile = true
}
}

provider "aws" {
  # Configuration options
 region = "us-east-1"
}