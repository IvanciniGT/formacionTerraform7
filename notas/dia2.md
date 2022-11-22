# Tipos de datos en terraform:

- String            Texto
- Number            Numero
- Bool              Valor lógico
- List()            Lista de datos. Los elementos son accesibles mediante su posición en la lista
- Set()             Lista de datos. Los elementos NO son accesibles mediante su posición en la lista
                                    Solo puedo acceder a ellos por ITERACION
- Map()             Conjunto de pares clave-valor. Las claves serán siempre Strings... los valores.. lo que se requiera
- Objets            Es un mapa con claves predefinidas

# Tipos de propiedades que puedo asignar a un recurso de terraform:

Las anteriores
+ BLOCK... Estos son diferentes a todos los demás... y se configuran con una sintaxis distinta.
            Se parecen a los objects