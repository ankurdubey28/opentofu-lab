variable "region" {
  type = string
  default = "ap-south-1"
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type=number
  default = 1
}

variable "monitoring" {
  default = true
  type = bool
}

variable "associate_public_ip_address" {
  type = bool
  default = true
}

variable "cidr_block" {
  description = "CIDR block for vpc"
  type = list(string)
  default = ["10.0.0.0/8","192.168.0.0/16"]
}

variable "allowed_region" {
  description = "Set of allowed AWS regions"
  type=set(string)
  default = ["us-east-1","ap-south-1","ap-south-2"]
}

variable "tags" {
  type = map(string)
  default = {
      Environment="dev"
      Name = "dev-EC2-Instance"
  }
}

variable "ingress_values" {
  type = tuple([
    string,
    number,
    number
  ])

  default = ["tcp", 443, 443]
}

variable "config" {
  type = object({
    region           = string
    monitoring     = bool
    instance_count = number
  })

  default = {
    region           = "ap-south-1"
    monitoring     = true
    instance_count = 1
  }
}