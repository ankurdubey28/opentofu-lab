# for indexable datastructures like list count works as order matters here
resource "aws_s3_bucket" "bucket1" {
  count = length(var.bucket_names1)
  bucket = var.bucket_names1[count.index]
  tags=var.tags
}

# for non indexable datastructures like set for_each is used as there is no way to get index for each set entry
# and order does not matter here
resource "aws_s3_bucket" "bucket2" {
  for_each = var.bucket_names2
  bucket = each.key   # for set each.key == each.value
  tags=var.tags

  depends_on = [aws_s3_bucket.bucket1]  #explicit dependency
}