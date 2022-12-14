

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
  name        = "miapache"
  image       = docker_image.miapache.image_id
  cpu_shares  = 2048 # El equivalente a una CPU al 100% 
  env         = [
                  "VARIABLE1=valor1",
                  "VARIABLE2=valor2"
                ]
  # Los bloques no llevan el signo igual
  ports {
    internal  = 80
    external  = 8080
  }
  ports {
    internal  = 443
    external  = 8443
  }
  # Una lista de bloques ... o un set.... se escribe replicando el bloque entero
}

# Quiero tener descargada esta imagen de contenedor 
resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
# NOTA: Al crear un recurso, tenemos a nuestra disposicion una variable llamada:
#.      TIPO_RECURSO.id_interno...... que contiene esa variable? Un objeto de tipo TIPO_RECURSO


# Terraform genera un grafo de dependencias entre los recursos.
# Los crea en base a ese grafo, primero recuros que no dependan de nadie
