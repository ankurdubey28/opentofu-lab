terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "ankur-28-apple-bucket-state"
    key="dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile=true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create a s3 Bucket
resource "aws_s3_bucket" "first-bucket" {
  bucket = "ankur-28-apple-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

