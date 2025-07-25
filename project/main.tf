
# create s3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.my_bucket.id
    key    = "index.html"
    source = "index.html"
    content_type = "text/html"
    acl = "public-read"
}

resource "aws_s3_object" "error" {
    bucket = aws_s3_bucket.my_bucket.id
    key    = "error.html"
    source = "error.html"
    content_type = "text/html"
    acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "name" {
    bucket = aws_s3_bucket.my_bucket.id
    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
    depends_on = [ aws_s3_bucket_acl.example ]
}