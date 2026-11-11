fix(dynamodb): cifrar la tabla de inventario con la CMK de SafeStock

Checkov: CKV_AWS_119 (Ensure DynamoDB Tables are encrypted using a KMS
Customer Managed CMK)
RNF: RNF-14 (AES-256 en reposo con claves administradas centralmente)

Estrategia: server_side_encryption con kms_key_arn = aws_kms_key.main.arn.
Por defecto DynamoDB cifra con una clave propiedad de AWS, sobre la que
no tenemos control ni trazabilidad. Con la CMK propia cada uso de la
clave queda en la auditoria y el acceso a los datos se puede revocar
desde una sola politica.

Alternativas descartadas:
- Clave propiedad de AWS (por defecto): sin control ni auditoria.
- Clave administrada aws/dynamodb: no permite politica ni rotacion
  propias.
Nota: el rol de las Lambdas que lean la tabla necesitara permisos
kms:Decrypt / kms:GenerateDataKey sobre esta clave.
