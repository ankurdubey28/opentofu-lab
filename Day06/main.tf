terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "environment" {
  default = "dev"
  type    = string
}

# create s3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "ankur_own-apple-bucket"

  tags = {
    Name        = local.bucket_name
    Environment = var.environment
  }
}
