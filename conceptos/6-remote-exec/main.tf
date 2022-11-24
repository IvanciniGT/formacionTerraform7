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

resource "docker_container" "contenedor" {
    name            = "miapache"
    image           = docker_image.imagen.image_id
    
    ports {
        internal    = 80
        external    = 8080
    }
    
    connection {
        type        =  "ssh"
        host        =   self.network_data[0].ip_address
        port        =   22
        user        =   "root"
        password    =   "root"
    }
    
    provisioner "remote-exec" {
        inline      = [ "echo Dentro del contenedor: EUREKA " , 
                        "echo Dentro del contenedor > /tmp/eureka.txt" ]
        # Equivalente al command del local-exec... Pero que permite muchos comandos
    }
    provisioner "remote-exec" {
        script      = "./script.sh" # fichero con un script en local
        #scripts     = [ "", "" ]
    }
    
    provisioner "file" {
        content     =  "Soy el contenido del fichero."
                        # Aqui con la sintaxis del EOT podeis poner todas las lineas que necesiteis
                        # Y además, usar variables, funciones......
        destination =   "/tmp/ficheroGenerado.txt"
    }
    provisioner "file" {
        source      =   "./fichero.txt"
        destination =   "/tmp/ficheroCopiado.txt"
    }
}
resource "docker_image" "imagen" {
    name            = "rastasheep/ubuntu-sshd:latest"
}
