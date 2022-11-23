# Tipos de datos en terraform:

- String            Texto
- Number            Numero
- Bool              Valor lógico
- List()            Lista de datos. Los elementos son accesibles mediante su posición en la lista
- Set()             Lista de datos. Los elementos NO son accesibles mediante su posición en la lista
                                    Solo puedo acceder a ellos por ITERACION
- Map()             Conjunto de pares clave-valor. Las claves serán siempre Strings... los valores.. lo que se requiera
- Objets            Es un mapa con claves predefinidas
                    Asociado a cada clave, puedo tener un tipo de datos distinto

# Tipos de propiedades que puedo asignar a un recurso de terraform:

Las anteriores
+ BLOCK... Estos son diferentes a todos los demás... y se configuran con una sintaxis distinta.
            Se parecen a los objects

# Terraform outputs

Los outputs nos permiten extraer información de salida de los recursos que 
generamos para utilizarla externamente a terarform

# Variables de terraform 

Nos permiten parametrizar los scripts y ... otras cosas...

Terraform NO PERMITE QUE UN SCRIPT se ejecute con VARIABLES SIN ASIGNAR

Como puedo darle valor a una variable...
De distintas formas:

- Poninendo un default value al declarar la variable en el script:                          NUNCA

- A través de la terminal... cuando ejecuto el script:                                      NUNCA
    por qué? Propenso a errores... Donde se ha ido la "AUTOMATIZACION"? Al carajo !

- En un fichero... De hecho en 2 ficheros:
    - .auto.tfvars... Lo puedo llamar como quiera... PERO ESA EXTENSION !!!!!!! !!!!!!      PARA VALORES POR DEFECTO
            ^ Además de ser un fichero SIMPLON.... Me sirve de plantilla para los .tfvars

    - .tfvars... Lo puedo llamar como quiera... y ponerle la extension que quiera !!!!!!
        Lo suministro al comando con el argumento --var-file                                SIEMPRE !

- Suministrando el valor en linea de comandos mediante el argumento --var "VARIABLE=VALOR"  Casi NUNCA
    por qué? NO DEJA RASTRO DEL VALOR. No deja ni huella... como la lejía ESTRELLA ! MIERDULI !!!
    cuándo si? CUANDO NO QUIERO DEJAR HUELLA ;)     Por ejemplo: Credencial !


El orden de precencia de las variables es:
    1º --var                MAYOR PRIORIDAD
    2º --var-file
    3º .auto.tfvars
    4º default
    5º Se me pide

NOTA: Es posible tener varios fichero .tfvars y .auto.tfvars aplicados simultaneamente
Escenario: Quiero crear una infra
    - Fichero configuración red
    - Fichero configuración servers
    


Jenkins
    Llaveros... Datos secretos
    terraform apply -auto-approve -var CONTRASEÑA_SUPERSECRETA=${Lo que haya en el llavero}

