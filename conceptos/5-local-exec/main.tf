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
  
  ports {
    internal  = 80
    external  = 8080
  }
  # Smoke test = Prueba de humo
  provisioner "local-exec" {
    command = "ping -c 1 ${self.network_data[0].ip_address}"
    # self en este caso es = docker_container.miapache
    #on_failure = continue
  }
  # Smoke test = Prueba de humo
  provisioner "local-exec" {
    command = "curl http://${self.network_data[0].ip_address}:80"
    # self en este caso es = docker_container.miapache
    #on_failure = continue
  }
  # Generar un fichero de inventario de ansible
  provisioner "local-exec" {
    command = "echo ${self.name}=${self.network_data[0].ip_address} > inventario.ini"
    # self en este caso es = docker_container.miapache
  }
}

resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
