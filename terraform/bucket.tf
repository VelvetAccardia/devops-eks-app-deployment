resource "aws_s3_bucket" "terraform_state" {
  bucket = "arthur-terraform-state-storage"
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }

}
