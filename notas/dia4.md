Generar un fichero con las ips de unos recursos que tengo en la infra

onCreate - onUpdate
---> Si creo, añadir en el fichero el que creo
---> Si modifico, eliminar del fichero y añadir la nueva entrada

onDestroy
---> Eliminar del fichero el que destruyo

# Me resuelve esto? 


## ejecucion 1 - Creo 3 apaches nuevos de cero  √
apache1 192.169.1.1
apache2 192.169.1.2
apache3 192.169.1.3

## ejecucion 2 - Creo 2 apaches más √
apache1 192.169.1.1
apache2 192.169.1.2
apache3 192.169.1.3
apache4 192.169.1.4
apache5 192.169.1.5

## ejecucion 3 - Elimino 2 apaches
apache1 192.169.1.1
apache3 192.169.1.3
apache5 192.169.1.5

## ejecucion 4 - Modifico 1 apache...
Dios quiera que le toque la IP.... Y entonces si...
Ya me toca montar un script guay que busque el que edito y 
    lo elimine y luego de uno de alta nuevos

