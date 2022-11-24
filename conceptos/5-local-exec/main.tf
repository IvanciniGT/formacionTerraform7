terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.23.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "docker" {
}
provider "null" {
}


resource "docker_container" "miapache" {
  count       = 3
  name        = "miapache_${count.index}"
  image       = docker_image.miapache.image_id
  
  ports {
    internal  = 80
    external  = 8080+count.index
  }
  # Smoke test = Prueba de humo
  provisioner "local-exec" {
    command = "ping -c 1 ${self.network_data[0].ip_address}"
    # self en este caso es = docker_container.miapache
  }
  provisioner "local-exec" {
    command = "curl http://${self.network_data[0].ip_address}:80"
    # on_failure = continue
    # when = destroy
  }
  # Generar un fichero de inventario de ansible
  #provisioner "local-exec" {
  #  command = "echo ${self.name}=${self.network_data[0].ip_address} >> inventario.ini"
    # Problemas:
    # Si ya había datos en el fichero: O lo sobreescribo, o le añado-
    # Si le añado, mal, ya que lo anterior lo pierdo (contenedores que ya existieran.. si solo estoy añadiendo)
    # Si borro contenedores (escalo hacia abajo) sus ips siguen en el fichero
    
    # Como podríamos resolverlo?
    # El fichero cuando se escriba, se escribe desde cero, incluyendo info de TODOS los contenedores
    #.   los que ya existieran, los nuevos, y los que se hayan eliminado (que desaparezcan)
    # Cuando querria yo hacer esto? Ante un evento que sea:
    #   Cuando cambien las ips 
  #}
}

resource "null_resource" "generar_fichero_inventario" {
  triggers = {
    federico = join("\n", [ for contenedor in docker_container.miapache: "${contenedor.name}=${contenedor.network_data[0].ip_address}" ] )
  }
  provisioner "local-exec" {
            # Borrar el fichero si existe inventario/inventario.txt
            # Vamos a crear una carpeta si no existe llamada inventario
            # Dentro de ella generamos un fichero inventario.txt
            # Con todos los nombres de contenedores y sus ips.
    command = <<EOT
                    mkdir -p inventario
                    echo "$MAQUINAS_CON_IPS" > inventario/inventario.txt
                EOT
            # Esta sintaxis la podeis usar en CUALQUIER propiedad...
            #   Permite meter varias lineas de texto.
    interpreter = ["/bin/bash", "-c"] # sh bash cmd python perl
    environment = {
                    MAQUINAS_CON_IPS = join("\n", [ for contenedor in docker_container.miapache: "${contenedor.name}=${contenedor.network_data[0].ip_address}" ] )
                  }
  } 
}

resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
