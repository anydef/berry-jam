terraform {
  backend "s3" {
    profile = "private"
    region = "eu-central-1"
    bucket = "terraform-backend-073833284785-eu-central-1"
    key = "monitoring.tfstate"
    role_arn = "arn:aws:iam::073833284785:role/terraform-role"
  }
}