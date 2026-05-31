terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket-637423185701-ap-south-1-an"
    key="dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile=true
  }
}