
output "direccion_ip_count" {
  value   = [ for contenedor in docker_container.miapache:
              contenedor.network_data[0].ip_address ]
}

output "direccion_ip_count_texto" {
  value   = join(",", [ for contenedor in docker_container.miapache:
              contenedor.network_data[0].ip_address ] )
}
output "direccion_ip_for_each" {
  value   = [ for clave, contenedor in docker_container.miapache_personalizado:
              contenedor.network_data[0].ip_address ]
              
              
}