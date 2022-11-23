variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor"
    validation {
        condition       = length(regexall("^[a-zA-Z][a-zA-Z0-9]{5,20}$",var.nombre_contenedor))==1
        error_message   = "El nombre del contenedor no es válido"
    }
}
variable "cuota_de_cpu" {
    type            = number
    description     = "Cuota para la CPU del contenedor"
    #default         = 1024 # ESTO NO SE HACE NUNCA EN LOS SCRIPTS !
                            # 1º Estos archivos son jodidos ... muy jodidos
                            # 2º Porque hay un sitio mejor !
    validation {
                          # Expresion que devuelva true si el dato es OK
        condition       = var.cuota_de_cpu > 0 # > < == != <= >= && ||
        error_message   = "La cuota de CPU debe ser mayor que 0"# Que se muestra si no se cumple la valdiacion
    }
    validation {
                          # Expresion que devuelva true si el dato es OK
        condition       = var.cuota_de_cpu <= 4096 # > < == != <= >= && ||
        error_message   = "La cuota de CPU debe ser menor o igual que 4096"# Que se muestra si no se cumple la valdiacion
    }
}
variable "variables_entorno_contenedor" {
    type            = list(object({
                                        clave   =   string
                                        valor   =   string
                                  }))
    description     = "Variables de entorno"
}
variable "imagen_repo" {
    type            = string
    description     = "Repo de la imagen del contenedor"
}
variable "imagen_tag" {
    type            = string
    description     = "Tag de la imagen del contenedor"
}
variable "puertos_expuestos" {
    #type            = list(map(number)) # No me garantiza las claves que se utilizan
    type            = list(object({
                                        interno = number
                                        externo = number
                                  }))
}