EXPOSICION = <museo, ciudadMuseo, nombreGaleria, nombreObra, añoCreacion, autorObra, precioEntrada>


DFs

DF1. museo -> ciudadMuseo
DF2. nombreObra -> añoCreacion
DF3. museo, nombreGaleria -> precioEntrada

(DF*. nombreObra -> nombreGaleria, museo :: no está explicitado y no la usé, pero se podría asumir que una obra no puede estar en dos museos diferentes, ni tampoco en dos galerias distintas dentro del mismo museo)

PK = <museo, nombreGaleria, nombreObra, autorObra>


EXPOSICION está en 1FN pero no está en 2FN pues ciudadMuseo y añoCreacion son los no-primos y dependen parcialmente de la clave. Normalizo aplicando DF1 y DF2 respectivamente.


MUSEO = <museo, ciudadMuseo>

OBRA = <nombreObra, añoCreacion> 

REXPO1 = <museo, nombreGaleria, nombreObra, autorObra, precioEntrada>


ahora MUSEO y OBRA están en 3FN pero REXPO1 está aún en 2FN pues precioEntrada no depende de nombreObra y autorObra

Normalizo REXPO1 mediante DF3.


ENTRADA = <museo, nombreGaleria, precioEntrada>

REXPO2 = <museo, nombreGaleria, nombreObra, autorObra>

ambas en 3FN.


Hasta ahí jamón. Ahora la cosa queda así:

m1 g1 o1 a1
m1 g1 o1 a2
m1 g1 o2 a1
m1 g2 o3 a1
m2 g1 o4 a1

(combinaciones legales de museo, galeria, obra y autor)

Acá es donde estoy asumiendo la relación entre una obra y su exposición en una galeria de un museo. No sé si está bien que lo haga dado que no lo usé funcionalmente.

Dependencias Multivaluadas que yo veo

DM1. museo ->> nombreGaleria, nombreObra, autorObra
DM2. nombreGaleria ->> museo, nombreObra, autorObra
DM3. nombreObra ->> autorObra
DM4. autorObra ->> nombreObra
DM5. museo, nombreGaleria ->> nombreObra, autorObra
DM6. museo, nombreObra ->> ...
DM7. museo, autorObra ->> nombreObra, nombreGaleria
DM8. nombreGaleria, nombreObra ->> autorObra
DM9. nombreGaleria, autorObra ->> nombreObra
DM10. nombreObra, autorObra ->> ...

Ok, sí, limón, voy limpiando.
DM6 y DM10 vuelan por alpedistas.
DM8 y DM9 salen porque en realidad la galería no interfiere, la multivaluación ya se dá en DM3 y DM4 respectivamente.
De DM1 vuelan nombreObra y autorObra por las mismas razones.
Ídem para autorObra en DM2.
DM7 sigue la misma linea.
En DM5 puedo quitar el autorObra.

Pasando en limpio me quedó:

DM1. museo ->> nombreGaleria
DM2. nombreGaleria ->> museo, nombreObra
DM3. nombreObra ->> autorObra
DM4. autorObra ->> nombreObra
DM5. museo, nombreGaleria ->> nombreObra

La lógica me indica que DM1 no tiene sentido porque si bien un museo multivalúa, una galería necesita del museo para identificarse.
En DM2 la galeria me multidetermina el museo y la obra, lo cual es lógico, en una galería hay muchas obras y los nombres de las galerías se repiten para diferentes museos.
DM3 y DM4 son intercambiables. Hay una relación N-N entre obra y autor, con lo cual cualquiera que deje va bien.
Y DM5 naturalmente en una galería en un museo hay muchas obras.

Yo dejaría las multivaluaciones asi:

DM3. nombreObra ->> autorObra
DM5. museo, nombreGaleria ->> nombreObra

Y separaría lo que es obra-autor con obra-museo-galeria, quedando las siguientes relaciones

AUTOR-OBRA = <nombreObra, autorObra>

REXPO3 = <museo, nombreGaleria, nombreObra>

Estando ambas, y las anteriores (MUSEO, OBRA y ENTRADA) en 4FN.

--fin--

Bien, no comprendo del todo lo que hago en 4FN normal, así que mal.

La intuición y la pseudológica me dice que tengo que separar así, pero no tengo un sustento teórico o un procedimiento práctico que me haga entender lo que estoy haciendo. Lo que en el mail anterior de alguna forma cerró, ahora se volvió a abrir (y eso que no maté DFs por el camino). Que me estoy perdiendo?


