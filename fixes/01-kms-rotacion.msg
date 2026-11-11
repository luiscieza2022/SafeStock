fix(kms): habilitar rotacion automatica de la clave principal

Checkov: CKV_AWS_7 (Ensure rotation for customer created CMKs is enabled)
RNF: RNF-14 (cifrado en reposo con claves administradas centralmente)

Estrategia: enable_key_rotation = true en aws_kms_key.main.
Esta unica CMK cifra DynamoDB, S3 y SQS. La rotacion anual automatica
limita la ventana de exposicion si se compromete material criptografico,
sin cambiar el ARN de la clave, sin re-cifrar datos a mano y sin tocar
los recursos que la usan.

Alternativas descartadas:
- Rotacion manual (crear clave nueva y migrar): propensa a error humano
  y cambia el ARN en todos los recursos.
- Claves administradas por AWS: no dan control propio de politica ni
  rotacion, contrario al "gestion centralizada" de RNF-14.
