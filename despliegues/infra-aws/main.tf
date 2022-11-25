
resource "aws_instance" "foo" {
    ami             = data.aws_ami.imagen_ubuntu.image_id
    instance_type   = "t2.micro"
    key_name        = resource.aws_key_pair.clave_publica_en_aws.key_name
    tags = {
        Name = "InstanciaDeIvan"  
    }
    
    // public_ip private_ip     Ping:       Pruebo que la maquina está on y conectada a red
    // conectar por ssh ...     Probamos:   El certificado o Puerto 
    //                          SI: Se que todo está bien
    //                          NO: No se qué pasa ¿?
    //                          Pruebas unitarias
    
    provisioner "local-exec" {
    
    
    connection {
        
    }
    
    provisioner "remote-exec" {
        
    }
    
}

module "claves" {
    source              = "../modulo"
    directorio_claves   = "./claves"
}

resource "aws_key_pair" "clave_publica_en_aws" {
    key_name    = "clave_publica_ivan"
    public_key  = module.claves.publicKey.openssh
}

data "aws_ami" "imagen_ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
