fix(s3): bloquear todo acceso publico al bucket del frontend

Checkov: CKV2_AWS_6 (Ensure that S3 bucket has a Public Access block);
tambien cubre CKV_AWS_53, CKV_AWS_54, CKV_AWS_55 y CKV_AWS_56
RNF: RNF-10 (seguridad en transito), RNF-18 (proteccion contra ataques)

Estrategia: aws_s3_bucket_public_access_block con los cuatro bloqueos
en true. En la arquitectura el contenido se entrega solo a traves de la
CDN, asi que el bucket nunca debe ser accesible directamente desde
Internet. Esto evita que una ACL o politica mal escrita lo exponga y
obliga a pasar por la CDN y el WAF.

Alternativas descartadas:
- Bucket publico con website hosting: se saltaria el WAF y el HTTPS
  forzado de la CDN.
Nota: una politica de Origin Access Control de CloudFront no cuenta como
publica, por lo que seguira funcionando.
