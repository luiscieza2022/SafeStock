resource "aws_s3_bucket" "web" {
  bucket = "safestock-web-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "web" {
  bucket = aws_s3_bucket.web.id

  versioning_configuration {
    status = "Enabled"
  }
}
