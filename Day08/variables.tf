variable "tags" {
  description = "Tags to apply to the S3 bucket."
  type        = map(string)

  default = {
    Name        = "wow-my-unique-bucket"
    Environment = "dev"
  }
}

variable "bucket_names1" {
  description = "list of S3 buckets to create"
  type = list(string)
  default = ["hello-world-bucket-1-unique","hello-world-bucket-2-unique"]
}

variable "bucket_names2" {
  description = "list of S3 buckets to create"
  type = set(string)
  default = ["hello-world-bucket-1-unique","hello-world-bucket-2-unique"]
}
