resource "aws_sqs_queue" "dlq" {
  name                      = "safestock-notifications-dlq"
  message_retention_seconds = 1209600
  kms_master_key_id         = aws_kms_key.main.arn
}
