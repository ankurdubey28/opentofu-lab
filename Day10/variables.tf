variable "tags" {
  type = map(string)
  default = {
    Environment="Dev"
    Name = "dev-instance"
    created_by="terraform"
    compliacne= "yes"
  }
}

variable "instance_count" {
  description = "Number of ec2 instances to be created"
  type = number
  default = 1
}

variable "environment" {
  description = "Environment"
  type = string
  default = "dev"
}

variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port=number
    to_port=number
    protocol=string
    cidr_blocks=list(string)
    description=string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS"
    }
  ]
}
