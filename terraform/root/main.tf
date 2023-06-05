terraform {
  backend "s3" {
    bucket = "arthur-terraform-state-storage"
    region = "us-west-1"
    key    = "storage-state.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0 "
    }
  }
}

provider "aws" {
  region = var.aws_region
}



module "aws_vpc" {
  source                         = "../modules/network"
  cidr_block                     = var.cidr_block
  tag_name                       = var.tag_name
  cidr_block_sub_pub_1_us_west_1 = var.cidr_block_sub_pub_1_us_west_1
  cidr_block_sub_pvt_1_us_west_1 = var.cidr_block_sub_pvt_1_us_west_1
  cidr_block_sub_pub_2_us_west_1 = var.cidr_block_sub_pub_2_us_west_1
  cidr_block_sub_pvt_2_us_west_1 = var.cidr_block_sub_pvt_2_us_west_1
  aws_availability_zone_1        = var.aws_availability_zone_1
  aws_availability_zone_2        = var.aws_availability_zone_2
  aws_region                     = var.aws_region
  domain                         = var.domain
  cname                          = var.cname
}

module "aws_rds" {
  source               = "../modules/rds"
  db_name              = var.db_name
  allocated_storage    = var.allocated_storage
  db_engine            = var.db_engine
  instance_class       = var.instance_class
  db_username          = var.db_username
  db_password          = var.db_password
  engine_version       = var.engine_version
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
}

module "aws_eks" {
  source                  = "../modules/eks"
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  pub_subnet_id_1         = var.pub_subnet_id_1
  pvt_subnet_id_1         = var.pvt_subnet_id_1
  pub_subnet_id_2         = var.pub_subnet_id_2
  pvt_subnet_id_2         = var.pvt_subnet_id_2
}
