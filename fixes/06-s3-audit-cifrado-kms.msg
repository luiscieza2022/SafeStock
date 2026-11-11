fix(s3): cifrar el bucket de auditoria con la CMK de SafeStock

Checkov: CKV_AWS_145 (Ensure that S3 buckets are encrypted with KMS by
default)
RNF: RNF-06 (registros cifrados e inmutables), RNF-14 (AES-256 con
claves centralizadas)

Estrategia: aws_s3_bucket_server_side_encryption_configuration con
sse_algorithm = "aws:kms" y la CMK central, mas bucket_key_enabled.
Los registros de auditoria son evidencia sensible: con KMS el acceso al
objeto exige tambien permiso sobre la clave y cada uso queda auditado.
bucket_key_enabled reduce las llamadas a KMS y, con ello, el costo.

Alternativas descartadas:
- SSE-S3 (AES256): cifra con AES-256 pero sin control ni trazabilidad
  de la clave.
