terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
  backend "s3" {
    bucket = "prathapbucket4413"
    key    = "terraform/terraformstatefile.tfstate"
    region = "ap-south-1"
    use_lockfile = true
  }
}
provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1"
}
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "instance_name" {
  description = "Name tag for the EC2 instance"
  default     = "prathapterra"
}

locals {
  common_tags = {
    Name = var.instance_name
    Environment = "Dev"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0f58b397bc5c1f2e8" # Example Amazon Linux AMI
  instance_type = var.instance_type

  tags = local.common_tags
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}
output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.web.public_dns
}

output "instance_tags" {
  description = "The tags associated with the EC2 instance"
  value       = aws_instance.web.tags
}
output "instance_name" {
  description = "The name of the EC2 instance"
  value       = aws_instance.web.tags["Name"]
}