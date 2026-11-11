fix(lambda): reservar concurrencia para la funcion de logica de negocio

Checkov: CKV_AWS_115 (Ensure that AWS Lambda function is configured for
function-level concurrent execution limit)
RNF: RNF-04 (escalabilidad), RNF-18 (proteccion ante DoS), RNF-27
(eficiencia de costos)

Estrategia: reserved_concurrent_executions = 100. Fija un techo
(~1000 req/s con 100 ms por llamada) que cubre los 3-5 tps por negocio,
evita que un pico o ataque agote la concurrencia de la cuenta y deje sin
servicio a otras funciones, y limita el gasto y la presion sobre
DynamoDB. Tambien garantiza esa capacidad a esta funcion.
Valor inicial: ajustar tras pruebas de carga.

Alternativas descartadas:
- Sin limite: una rafaga descontrolada consume toda la cuota de la
  cuenta y el costo.
Nota: la cuenta debe tener al menos 100 + 10 de cuota de concurrencia;
las cuentas nuevas pueden tener solo 10 (solicitar aumento).
