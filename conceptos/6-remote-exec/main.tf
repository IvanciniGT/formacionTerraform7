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
}

resource "docker_image" "miapache" {
  name      = "httpd:latest"
}
