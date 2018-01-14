P2E2i: EVALUACIONES

EVALUACIONES = <dniAlu, legajoAlu, codMateria, nombreMateria, fecha, nyapAlu, dirAlu, ciudadAlu, codProf, nombreProf, nota, correlativasMateria>


DF1. codProf -> nombreProf 
DF3. codMateria, fecha, legajoAlu -> codProf
DF4. codMateria -> nombreMateria
DF5. legajoAlu -> dniAlu, nyapAlu, dirAlu, ciudadAlu
DF6. codMateria, fecha, legajoAlu -> nota
DF7. codMateria -> correlativasMateria

Entiendo que hay una sola CK, entonces, PK = <codMateria, fecha, legajoAlu>

como EVALUACIONES no está en 1FN, aplico DF7

CORRELATIVAS = <codMateria, codCorrelativa>
REVAL1 = EVALUACIONES - {correlativasMateria}

luego CORRELATIVAS está en 1FN, 2FN, 3FN, 4FN.


como REVAL1 está en 1FN pero no en 2FN, aplico DF4

MATERIA = <codMateria, nombreMateria>
REVAL2 = REVAL1 - {nombreMateria}

luego MATERIA está en 1FN, 2FN, 3FN, 4FN


como REVAL2 sigue sin estar en 2FN, aplico DF1

PROFESOR = <codProf, nombreProf>

REVAL3 = REVAL2 - {nombreProf}

luego PROFESOR está en 1FN, 2FN, 3FN, 4FN


como REVAL3 aún no está en 2FN, aplico DF5

ALUMNO = <legajoAlu, dniAlu, nyapAlu, dirAlu, ciudadAlu>

REVAL4 = REVAL3 - {dniAlu, nyapAlu, dirAlu, ciudadAlu}

luego ALUMNO está en 1FN, 2FN, 3FN, 4FN


ahora tengo REVAL4 = <legajoAlu, codMateria, fecha, codProf, nota>
que está en 1FN, 2FN, 3FN
pues tanto codProf como nota (los no-primos) dependen de la clave completa
y además dependen de forma directa.


Analizando las dependencias multivaluadas entiendo lo siguiente:

DM1. codMateria ->> codCorrelativa
DM2. codProf, fecha ->> materia
DM3. codProf, fecha ->> alumno
DM4. codProf, fecha ->> nota

DM1 alcanza sólo a CORRELATIVAS, con lo cual siendo una dependencia trivial, garantiza la 4FN en esa tabla.

DM2, DM3, DM4, son similares, pero yo no puse a codProf como parte de la clave, con lo cual no me termina de cerrar y no logro ver si es que REVAL4 está en 4FN o es que me equivoqué al definir la PK. Pero me da la impresión que la PK está bien porque nota y codProf son funcionalmente dependientes de forma completa.


Espero que se entienda el procedimiento.
