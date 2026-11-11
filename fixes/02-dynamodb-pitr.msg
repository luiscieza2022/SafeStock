fix(dynamodb): activar point-in-time recovery en la tabla de inventario

Checkov: CKV_AWS_28 (Ensure DynamoDB point in time recovery is enabled)
RNF: RNF-05 (respaldos), RNF-08 (restauracion en <= 45 min)

Estrategia: bloque point_in_time_recovery { enabled = true }.
PITR guarda respaldos continuos (hasta 35 dias) y permite restaurar la
tabla a cualquier segundo, dando un RPO de segundos frente a las 24 h
del respaldo diario Full. Se restaura a una tabla nueva, compatible con
el RTO < 45 min. Complementa a AWS Backup (retencion de 15 dias), no lo
reemplaza.

Alternativas descartadas:
- Solo respaldos on-demand/diarios: RPO de hasta 24 h, se perderian las
  ventas del dia ante corrupcion de datos.
- Exportaciones manuales a S3: dependen de una persona y no son
  restauraciones directas.
