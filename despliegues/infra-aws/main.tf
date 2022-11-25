
resource "aws_instance" "foo" {
    ami             = data.aws_ami.imagen_ubuntu.image_id
    instance_type   = "t2.micro"
    key_name        = resource.aws_key_pair.clave_publica_en_aws.key_name
    tags = {
        Name = "InstanciaDeIvan"  
    }
    security_groups = [ aws_security_group.permitir_todo.name ]
    
    // public_ip private_ip     Ping:       Pruebo que la maquina está on y conectada a red
    // conectar por ssh ...     Probamos:   El certificado o Puerto 
    //                          SI: Se que todo está bien
    //                          NO: No se qué pasa ¿?
    //                          Pruebas unitarias
    # Smoke test = Prueba de humo
    provisioner "local-exec" {
        command = "sleep 20 && ping -c 1 ${self.public_ip}"
    }    
    
    connection {
        type        =  "ssh"
        host        =   self.public_ip
        port        =   22
        user        =   "ubuntu"
        private_key =   module.claves.privateKey.pem
    }
    
    provisioner "remote-exec" {
        inline      = [ "echo EUREKA " ]
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

resource "aws_security_group" "permitir_todo" {
  name        = "reglas_firewall_ivan"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "reglas_firewall_ivan"
  }
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


resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

/*
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  
*/