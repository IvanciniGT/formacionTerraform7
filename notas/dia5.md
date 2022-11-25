
script      --->    terraform   ---> init   ---> descargar el proveedor
                                                    v
declaramos                      ---> apply  --->  proveedor aws ------> aws cli ----->  aws
un proveedor
aws

---
## Control del estado de la infraestructura

terraform refresh                       Refresca con el proveedor
terraform show                          Muestra todos los recursos con toda su info
terraform state list                    Muestra solo los nombres de recursos
terraform state show aws_instance.foo   Muestra los datos de un recurso

## Grafo de dependencias

terraform graph -type=plan | dot -Tsvg > infra.svg
terraform graph -type=plan-destroy | dot -Tsvg > infra.svg
terraform graph -type=apply | dot -Tsvg > infra.svg
