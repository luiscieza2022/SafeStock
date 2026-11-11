resource "aws_dynamodb_table" "inventory" {
  name         = "safestock-inventory"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "business_id"
  range_key    = "product_id"

  attribute {
    name = "business_id"
    type = "S"
  }

  attribute {
    name = "product_id"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.main.arn
  }
}
