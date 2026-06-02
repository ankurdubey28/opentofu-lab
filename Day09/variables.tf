variable "allowed_vm_types" {
  description = "List of allowed VM types"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t3.micro"]
}

variable "allowed_region" {
  description = "set of allowed regions"
  type = set(string)
  default = ["ap-south-1", "us-east-1", "eu-west-1"]
}

variable "ami_id" {
  description = "AMI ID used by the EC2 lifecycle examples"
  type        = string
  default     = "ami-0e8459476fed2e23b"
}

variable "common_tags" {
  description = "Common tags shared across Day09 examples"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "opentofu-lab"
  }
}

variable "create_before_destroy_name" {
  description = "Name tag for the create_before_destroy example"
  type        = string
  default     = "day09-create-before-destroy"
}

variable "prevent_destroy_name" {
  description = "Name tag for the prevent_destroy example"
  type        = string
  default     = "day09-prevent-destroy"
}

variable "ignore_changes_bucket_prefix" {
  description = "Bucket name prefix for the ignore_changes example"
  type        = string
  default     = "day09-ignore-changes"
}

variable "ignore_changes_environment_tag" {
  description = "Environment tag value used by the ignore_changes example"
  type        = string
  default     = "dev"
}

variable "dependency_bucket_prefix" {
  description = "Bucket name prefix for the dependency bucket used by replace_triggered_by"
  type        = string
  default     = "day09-dependency"
}

variable "replace_triggered_by_bucket_prefix" {
  description = "Bucket name prefix for the replace_triggered_by example"
  type        = string
  default     = "day09-replace-triggered"
}

variable "condition_bucket_prefix" {
  description = "Bucket name prefix for the precondition and postcondition example"
  type        = string
  default     = "day09-condition"
}
