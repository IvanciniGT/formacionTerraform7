provider "docker" {
}

resource "docker_container" "contenedor" {
  name        = var.nombre_contenedor
  image       = docker_image.imagen.image_id
  cpu_shares  = var.cuota_de_cpu 
  env         = var.variables_entorno_contenedor
  # start       = true | false
  ports {
    internal  = 80
    external  = 8080
  }
  ports {
    internal  = 443
    external  = 8443
  }
}

resource "docker_image" "imagen" {
  # Interporlación de textos
  name      = "${var.imagen_repo}:${var.imagen_tag}"
}
