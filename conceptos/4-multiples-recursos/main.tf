terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.23.0"
    }
  }
}
provider "docker" {
}


# Qué devuelve la variable docker_container.miapache?
#   Devuelve una lista de objetos de tipo docker_container
# Esto ocurre por haber usado COUNT
resource "docker_container" "miapache" {
  count       = var.numero_contenedores # Aqui hay que muninistrar un numero
                # Al usar count, tenemos a nuestra disposicion la variable count.index
                # Que nos dice, por cual vamos
  name        = "miapache_${count.index}"
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = 8080 + count.index
  }
}

# Qué devuelve la variable docker_container.miapache_personalizado?
#   Devuelve un mapa de objetos de tipo docker_container
# Esto ocurre por haber usado FOR_EACH
# Cada objeto de ese mapa tiene por clave? La mismas claves del mapa original
# .... el que metimos en el for_each
resource "docker_container" "miapache_personalizado" {
  for_each    = var.contenedores_personalizados # Mapa de cosas, las que sean... o una lista de TEXTOS (que valen pa' poco)
                # Al meter la palabra for_each en un resource, tenemos a nuestra disposició
                # la variable each, a la que le puedo pedir:
                #   each.key
                #   each.value
  name        = each.key
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = each.value
  }
}

resource "docker_container" "miapache_mas_personalizado" {
  for_each    = var.contenedores_mas_personalizados
  name        = each.key
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = each.value.puerto
    ip        = each.value.ip
  }
}

resource "docker_container" "miapache_mas_personalizado_2" {
  count       = length(var.contenedores_mas_personalizados_2)
  name        = var.contenedores_mas_personalizados_2[count.index].nombre
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = var.contenedores_mas_personalizados_2[count.index].puerto
    ip        = var.contenedores_mas_personalizados_2[count.index].ip
  }
}
#### ^ BUCLES 

#### v CONDICIONAL 

# En cualquier caso, que me devuelve docker_container.mibalanceador?
# Una lista con 1 o ningñun objeto de tipo docker_container
resource "docker_container" "mibalanceador" {
  count       = var.quieres_balanceador ? 1 : 0
  name        = "mibalanceador"
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = 9012
  }
}

# Qué devuelve la variable docker_image.miapache?
#   Devuelve un objeto de tipo docker_image
resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
