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

## Cuando escribimos un programa .....

Qué hacemos con el código... 
- LO ENCAPSULAMOS
- LO ORGANIZAMOS

Voy a tener un montón de lineas por ahi en mi programa una detrás de otra?     Programación IMPERATIVA
    Hace programas complejos
    No permite reutilizar código
    No encapsula
    Dificil de testear y debugear

Funciones / Procedimientos / Métodos / Rutinas / Modulos (en terraform)

Un módulo de terraform es el quivalente en otros lenguajes a una función.
Sirve para: 
    Reutilización
    Encapsulación

Las funciones:
1º Las tengo que definir
2º Las tengo que invocar/llamar... Y al llamarlas:
    - Les paso parametros/argumentos/variables(terraform)
    - Y al acabar me devuelven un/unos datos: return / output(terraform)
    
Un modulo de terraform, es un conjunto de variables, recursos, outputs y proveedores (sin su configuración)
que podemos reutilizar.

Un script de terraform, es un conjunto de variables, recursos, outputs y proveedores (con su configuración)