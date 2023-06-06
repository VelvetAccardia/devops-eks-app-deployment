terraform {
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


resource "aws_s3_bucket" "terraform_state" {
  bucket = "arthur-terraform-state-storage"
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }

}
