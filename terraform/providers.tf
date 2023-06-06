terraform {
  backend "s3" {
    bucket = "arthur-terraform-state-storage"
    region = "us-west-1"
    key    = "storage-state.tfstate"
  }
}
