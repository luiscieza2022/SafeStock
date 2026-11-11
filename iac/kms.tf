resource "aws_kms_key" "main" {
  description             = "Clave central SafeStock (cifrado en reposo)"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "main" {
  name          = "alias/safestock-main"
  target_key_id = aws_kms_key.main.key_id
}
