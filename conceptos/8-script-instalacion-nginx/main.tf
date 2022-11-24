
provider "docker" {
}

module "nginx" {
    source  =   "../7-modulo-contenedor"   # import  |  using
            # Tipos de sources que podemos poner: https://developer.hashicorp.com/terraform/language/modules/sources
    nombre_contenedor               = var.nombre_contenedor
    imagen_repo                     = "nginx"
    imagen_tag                      = var.imagen_tag
    puertos_expuestos               = [
                                            {
                                                interno =   80
                                                externo =   var.puerto
                                            }
                                      ]
}

module "apache" {
    source  =   "../7-modulo-contenedor"   # import  |  using
            # Tipos de sources que podemos poner: https://developer.hashicorp.com/terraform/language/modules/sources
    nombre_contenedor               = "miapache"
    imagen_repo                     = "httpd"
    imagen_tag                      = "latest"
    puertos_expuestos               = [
                                            {
                                                interno =   80
                                                externo =   var.puerto +1
                                            }
                                      ]
}
