terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}



# create ec2 bucket
resource "aws_instance" "example" {
  count = var.instance_count
  ami = "ami-0e8459476fed2e23b"
  instance_type = "t2.mciro"
  region = tolist(var.allowed_region)

  monitoring =var.monitoring
  associate_public_ip_address =var.associate_public_ip_address

  tags=var.tags
}

# create policy group
resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
  description = "Allow TLS inbound and all outbound traffic"

  tags = {
    Name="allow_tls"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  from_port = var.ingress_values[1]
  to_port = var.ingress_values[2]
  ip_protocol = var.ingress_values[0]
  cidr_ipv4 = var.cidr_block[0]
}