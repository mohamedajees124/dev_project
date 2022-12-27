# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami               = "ami-0b5eea76982371e91"
  instance_type     = "t2.medium"
  availability_zone = "us-east-1a"
  key_name          = "key1"
  security_groups   = ["openall"]
  user_data         = <<-EOF
    #!/bin/bash
    sudo yum install python-pip
    EOF
  for_each = {
    Sonar  = "instance-1"
    Nexus   = "Instance-2"
  }
  tags = {
    "Name" = "${each.key}"
    "tag" = "${each.key}-${each.value}"    
  }
}

resource "aws_db_instance" "mysonar" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7.33"
  instance_class       = "db.t3.micro"
  identifier           = "mysonar"
  publicly_accessible  = true 
  username             = "mysonar"
  password             = "admin123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
