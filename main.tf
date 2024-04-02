terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
  required_version = ">= 1.2.0"

  backend "s3" {
  bucket = "maven-app"
  key    = "StateFile"
  region = "eu-north-1"
  encrypt = true

}

provider "aws" {
  region = "eu-north-1"
}


data "aws_vpc" "default" {
 default = true
}

resource "aws_instance" "aws_maven-app" {
  ami           = "ami-0914547665e6a707c"
  instance_type = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.maven-app_sg.id]
  key_name = "key_pair1"
  tags = {
    Name = "maven-app"
  }
  user_data     =  "${file("script.sh")}"
}




resource "aws_security_group" "maven-app_sg" {
 name        = "maven-app-sg"
 description = "elk stack security group"
 vpc_id      = "vpc-05b62589856924a60"

    ingress {
       description = "port-80"
       from_port   = 80
       to_port     = 80
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
       description = "port-ssh"
       from_port   = 22
       to_port     = 22
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }
}
