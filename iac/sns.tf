resource "aws_sns_topic" "alerts" {
  name              = "safestock-critical-alerts"
  kms_master_key_id = "alias/aws/sns"
}
