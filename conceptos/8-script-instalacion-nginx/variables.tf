variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor"
    validation {
        condition       = length(regexall("^[a-zA-Z][a-zA-Z0-9]{5,20}$",var.nombre_contenedor))==1
        error_message   = "El nombre del contenedor no es válido"
    }
}
variable "imagen_tag" {
    type            = string
    description     = "Tag de la imagen del contenedor"
}
variable "puerto" {
    type            = number
    description     = "Que le faltaría su validación y como ya sabemos hacelro, no lo hago"
}
