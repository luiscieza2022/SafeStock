fix(sns): cifrar en reposo el topico de alertas criticas

Checkov: CKV_AWS_26 (Ensure all data stored in the SNS topic is
encrypted)
RNF: RNF-09 (alarma critica en <= 1 min), RNF-14 (cifrado en reposo)

Estrategia: kms_master_key_id = "alias/aws/sns" (clave administrada por
AWS). Las alarmas de CloudWatch publican en este topico; con una CMK
propia habria que agregar a su politica el principal
cloudwatch.amazonaws.com y, si se olvida, las alarmas fallarian en
silencio justo cuando mas se necesitan. La clave administrada ya lo
permite y cifra en reposo.

Alternativas descartadas:
- CMK propia: mayor control, pero riesgo de romper la entrega de alarmas
  si la politica de clave no esta completa. Se podra migrar despues.
