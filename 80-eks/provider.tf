terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.9.0"
    }
  }
  backend "s3" {
  bucket = "harsha84-aws-eks"
  key    = "eks"
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