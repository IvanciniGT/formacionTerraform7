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

resource "docker_container" "miapache" {
  name        = "miapache"
  image       = docker_image.miapache.image_id
}

resource "docker_image" "miapache" {
  name          = data.docker_registry_image.miapache.name #"httpd:latest" # esto no vale. porqué? GRAFO DE DEPENDENCIAS !!!!!!! #
  pull_triggers = [ data.docker_registry_image.miapache.sha256_digest ]
                // Terraform mira si el dato PULL_TRIGGER es distinto del que hay en .tfstate
}                                           // ^ Este es el que cargo de cocker hub

data "docker_registry_image" "miapache" {
  name = "httpd:latest"
}

// CON EL DATA

// Que pasa el dia 1 que ejecuto esto? terraform apply
// 1º Miro en el registry (docker hub) cual es la imagen que hay httpd:latest
// 2º Descargo la imagen que he usado en el data. Que mira terraform para ello? name
//    pull_triggers? vale para algo? claro.. Se mira el valor actual, comparado con el anterior: PROVIDER


// SIN EL DATA

// Que pasa el dia 1 que ejecuto esto? terraform apply
// 1º Descargar la imagen de Apache HTTPD... Cuál ? La que tenga la etiqueta LATEST
// 2º Crear un contenedor con esa imagen

// Un año más tarde... ejecuto de nuevo: terraform apply
// 1º Se vuelve a descargar la imagen LATEST de apache? Ni de coña! Tengo ya una imagen LATEST ... SI.
//      Hay algún cambio? NO. Imagen OK
// 2º Ya hay contenedor con esa imagen LATEST. Todo OK !!!