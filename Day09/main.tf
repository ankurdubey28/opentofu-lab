data "aws_caller_identity" "current" {}

# Example 1: create the replacement instance first, then destroy the old one.
resource "aws_instance" "create_before_destroy_demo" {
  ami           = var.ami_id
  instance_type = var.allowed_vm_types[0]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = var.create_before_destroy_name
  })
}

# Example 2: block accidental deletion of an important resource.
resource "aws_instance" "prevent_destroy_demo" {
  ami           = var.ami_id
  instance_type = var.allowed_vm_types[0]

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = var.prevent_destroy_name
  })
}

# Example 3: ignore drift on a specific tag if it changes outside OpenTofu/Terraform.
resource "aws_s3_bucket" "ignore_changes_demo" {
  bucket = "${var.ignore_changes_bucket_prefix}-${data.aws_caller_identity.current.account_id}"

  tags = merge(var.common_tags, {
    Name        = var.ignore_changes_bucket_prefix
    Environment = var.ignore_changes_environment_tag
  })

  lifecycle {
    ignore_changes = [
      tags["Environment"]
    ]
  }
}

# If this bucket is replaced, the bucket below will also be replaced.
resource "aws_s3_bucket" "dependency_demo" {
  bucket = "${var.dependency_bucket_prefix}-${data.aws_caller_identity.current.account_id}"
}

# Example 4: force replacement when a related resource changes.
resource "aws_s3_bucket" "replace_triggered_by_demo" {
  bucket = "${var.replace_triggered_by_bucket_prefix}-${data.aws_caller_identity.current.account_id}"

  lifecycle {
    replace_triggered_by = [
      aws_s3_bucket.dependency_demo
    ]
  }
}

# Example 5: validate assumptions before and after resource creation.
resource "aws_s3_bucket" "condition_demo" {
  bucket = "${var.condition_bucket_prefix}-${data.aws_caller_identity.current.account_id}"

  lifecycle {
    precondition {
      condition     = length("${var.condition_bucket_prefix}-${data.aws_caller_identity.current.account_id}") <= 63
      error_message = "S3 bucket names must be 63 characters or fewer."
    }

    postcondition {
      condition     = self.bucket_domain_name != ""
      error_message = "The bucket domain name should be available after creation."
    }
  }
}
