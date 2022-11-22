# En HCL: Podemos poner comentarios usando el cuadrito!

# Objetivo del script: CREAR ENTORNOS DE CLOUD 9 en AWS

# Este bloque terraform me permite especificar qué providers quiero utilizar.
# Habitualmente serán varios.
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.23.0"
    }
  }
}