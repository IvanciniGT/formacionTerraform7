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

# Para cada proveedor que tengamos declarado, tendremos que establecer su configuración.
# Hay proveedores que no requieren configuración. 
# Otros algo
# Otros mucha

provider "docker" {
  # Configuration options
}

#resource "TIPO_RECURSO" "id_interno" {

# Quiero tener un contenedor creado desde una determinada imagen, y con un nombre 
resource "docker_container" "miapache" {
  ## Configuración del recurso
  name      = "miapache"
  image     = docker_image.miapache.image_id
}

# Quiero tener descargada esta imagen de contenedor 
resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
# NOTA: Al crear un recurso, tenemos a nuestra diosposicion una variable llamada:
#.      TIPO_RECURSO.id_interno...... que contiene esa variable? Un objeto de tipo TIPO_RECURSO


# Terraform genera un grafo de dependencias entre los recursos.
# Los crea en base a ese grafo, primero recuros que no dependan de nadie
