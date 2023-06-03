terraform {
  backend "s3" {
    bucket = "velvetaccardia-terraform-remote-state"
    region = "sa-east-1"
    key    = "terraform/states/test.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~≳ 4.0 "
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

module "aws_vpc" {
  source     = "../modules/network"
  cidr_block = var.cidr_block
  tag_name   = var.tag_name
}

module "aws_rds" {
  source               = "../modules/rds"
  db_name              = var.db-name
  allocated_storage    = var.allocated-storage
  db_engine            = var.db-engine
  engine_version       = var.engine_version
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
}
