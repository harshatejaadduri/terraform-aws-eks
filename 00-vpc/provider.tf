terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.0"
    }
  }
  backend "s3" {
  bucket = "harsha84-aws-eks"
  key    = "roboshop-terraform-vpc"
  region = "us-east-1"
  encrypt = true
  use_lockfile = true
}
}
provider "aws" {
  # Configuration options
 region = "us-east-1"
}