provider "docker" {
}

resource "docker_container" "contenedor" {
  name        = var.nombre_contenedor
  image       = docker_image.imagen.image_id
  cpu_shares  = var.cuota_de_cpu 
  env         = [ for variable_de_entorno in var.variables_entorno_contenedor: 
                  "${variable_de_entorno.clave}=${variable_de_entorno.valor}" ]
  # start       = true | false
  
  # Esta sintaxis SOLO VALE PARA BLOQUES DINAMICOS 
  dynamic "ports" {
    for_each  = var.puertos_expuestos # Lista de cosas... las que sean...
    iterator  = puerto  # A cada cosa de la lista me podré referir mediante lo que ponga Aqui!
    content {
      internal  = puerto.value["interno"]
      external  = puerto.value["externo"]
    }
  }
}

resource "docker_image" "imagen" {
  # Interporlación de textos
  name      = "${var.imagen_repo}:${var.imagen_tag}"
}
