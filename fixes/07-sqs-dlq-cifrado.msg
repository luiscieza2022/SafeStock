fix(sqs): cifrar la cola de mensajes fallidos con la CMK de SafeStock

Checkov: CKV_AWS_27 (Ensure all data stored in the SQS queue is
encrypted)
RNF: RNF-07 (0% de mensajes perdidos), RNF-14 (cifrado en reposo)

Estrategia: kms_master_key_id = aws_kms_key.main.arn en la DLQ.
Los mensajes que llegan a la DLQ conservan el contenido original
(ordenes de reposicion, datos de proveedores). Reutilizar la CMK central
mantiene un unico punto de control y auditoria de claves.

Alternativas descartadas:
- SSE-SQS (sqs_managed_sse_enabled): cifra, pero sin control propio de
  la clave (RNF-14).
- Una clave KMS por recurso: mas costo y mas administracion.
Nota: cuando se conecten productores y consumidores, sus roles
necesitaran kms:GenerateDataKey y kms:Decrypt sobre la clave.
