variable "project_name" {
  default = "Project ALPHA resource"
}

variable "raw_project_name" {
  type    = string
  default = "  Project ALPHA resource  "
}

variable "ports" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "nested_ports" {
  type    = list(list(number))
  default = [[22, 80], [443], [8080, 9000]]
}

variable "monthly_cost" {
  type    = number
  default = 18.25
}

variable "server_count" {
  type    = string
  default = "3"
}

variable "default_tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
    Team      = "DevOps"
  }
}

variable "extra_tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "alpha"
  }
}

variable "environment_instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    qa   = "t2.small"
    prod = "t3.medium"
  }
}

variable "environment" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be one of: dev, qa, prod."
  }
}

variable "preferred_region" {
  type    = string
  default = ""
}

variable "fallback_region" {
  type    = string
  default = "us-east-1"
}
