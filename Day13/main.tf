resource "aws_s3_bucket" "first_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.first_bucket.id
  ignore_public_acls = true
  block_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "allow_cf" {
  bucket = aws_s3_bucket.first_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  depends_on = [aws_s3_bucket_public_access_block.access_block]
}


data aws_iam_policy_document "allow_access_from_another_account" {
  statement {
    sid = "AllowCloudFrontServicePrincipal"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      # "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.first_bucket.arn}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.first_bucket.id
  for_each = fileset("${path.module}/www", "**/*")
  key    = each.value
  source = "${path.module}/www/${each.value}"
  etag = filemd5("${path.module}/www/${each.value}")
  content_type = lookup(
    {
      "html" = "text/html"
      "css"  = "text/css"
      "json" = "application/json"
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "application/octet-stream"
  )
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.first_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id   = local.origin_id
  }
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET","HEAD"]
    cached_methods = ["GET","HEAD"]
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["IN"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}