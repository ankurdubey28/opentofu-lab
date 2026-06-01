output "bucket_names_list" {
  value = [for i in var.bucket_names1:i]
}

output "bucket_ids_list" {
  value = [for b in aws_s3_bucket.bucket1:b.id]
}