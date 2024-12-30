terraform {
  backend "s3" {
    bucket         = "achia-terraform"
    key            = "achia-terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "achia-t-lock"
    encrypt        = true
  }
}