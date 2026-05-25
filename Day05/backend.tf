terraform {
  backend "s3" {
    bucket = "ankur-28-apple-bucket-state"
    key="dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile=true
  }
}