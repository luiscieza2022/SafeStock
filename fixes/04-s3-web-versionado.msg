fix(s3): habilitar versionado en el bucket del frontend

Checkov: CKV_AWS_21 (Ensure all data stored in the S3 bucket have
versioning enabled)
RNF: RNF-28 (despliegues sin caida), RNF-01 (disponibilidad)

Estrategia: recurso aws_s3_bucket_versioning con status = "Enabled".
El informe define el rollback del frontend volviendo a la version previa
de los archivos. Sin versionado, un despliegue defectuoso sobrescribe
los objetos y no hay a que volver. Tambien protege ante borrados o
sobrescrituras accidentales.

Alternativas descartadas:
- Conservar copias manuales del build: no es reproducible ni auditable.
Costo: se guardan versiones antiguas; se mitigara luego con una regla de
ciclo de vida que expire versiones no vigentes.
