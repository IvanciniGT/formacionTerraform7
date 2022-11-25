
resource "aws_instance" "foo" {
    ami           = data.aws_ami.imagen_ubuntu.image_id
    instance_type = "t2.micro"
    tags = {
        Name = "InstanciaDeIvan"  
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
