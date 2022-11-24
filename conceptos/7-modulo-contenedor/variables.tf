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
    nullable        = true # false, por defecto
                        # Esto hace que la variable pueda recibir además de un numero
                        # el valor nulo
    description     = "Cuota para la CPU del contenedor"
    default         =   null
    validation {
                          # Expresion que devuelva true si el dato es OK
        condition       = var.cuota_de_cpu == null ? true : var.cuota_de_cpu > 0 # > < == != <= >= && ||
                        # Condicional: Mediante el operador ternario
                        #       CONDICION ? VALOR_SI_TRUE : VALOR_SI_FALSE
        error_message   = "La cuota de CPU debe ser mayor que 0"# Que se muestra si no se cumple la valdiacion
    }
    validation {
                          # Expresion que devuelva true si el dato es OK
        condition       = var.cuota_de_cpu == null ? true : var.cuota_de_cpu <= 4096 # > < == != <= >= && ||
        error_message   = "La cuota de CPU debe ser menor o igual que 4096"# Que se muestra si no se cumple la valdiacion
    }
}
variable "variables_entorno_contenedor" {
    type            = list(object({
                                        clave   =   string
                                        valor   =   string
                                  }))
    description     = "Variables de entorno"
    default         = []
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
                                        ip      = optional(string, "0.0.0.0") # optional(string) equivalente a escribir optional(string, null) 
                                                 # Nos permite definir propiedades no obligatorias.
                                                 # CUIDADO. Que siempre un dato tiene que tener valor en terraform
                                                 # Y esta función lo que hace es, si no se da el dato, meter un
                                                 # valor por defecto, que se puede suministrar como segundo argumento
                                                 # En caso de no suministrarse, se usa por defecto el valor null
                                  }))
    default             = []
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_expuestos: puerto.interno < 65000 ] )
        error_message   = "El puerto interno debe ser menor de 65000"
    }
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_expuestos: puerto.externo < 65000 ] )
        error_message   = "El puerto externo debe ser menor de 65000"
    }
    validation {
        condition       = alltrue ( 
                                    [ for puerto in var.puertos_expuestos: 
                                        length(regexall("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.){3}(25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)$", puerto.ip))==1
                                    ] 
                                  )
        error_message   = "La IP no es correcta"
    }
    
}