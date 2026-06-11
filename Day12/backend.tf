terraform {
  backend "s3" {
    bucket                      = "aws-tf"
    key                         = "day12/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    access_key                  = "floci"
    secret_key                  = "floci"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}
