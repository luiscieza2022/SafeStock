fix(lambda): activar trazabilidad X-Ray en la funcion de logica de negocio

Checkov: CKV_AWS_50 (X-ray tracing is enabled for Lambda)
RNF: RNF-02 (latencia p95 < 800 ms), RNF-09 (observabilidad)

Estrategia: tracing_config { mode = "Active" } y adjuntar la politica
AWSXRayDaemonWriteAccess al rol de la funcion. Sin trazas no se puede
saber si el tiempo de una consulta de stock se va en la Lambda, en
DynamoDB o en un arranque en frio, y el SLA de latencia no seria
verificable. Active usa el muestreo por defecto, lo que mantiene el
costo bajo.

Alternativas descartadas:
- Solo logs de CloudWatch: no correlacionan una peticion entre servicios.
- Modo PassThrough: solo traza si el llamador ya lo hizo.
