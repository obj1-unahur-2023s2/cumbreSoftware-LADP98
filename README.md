# Cumbre mundial del software

Se va a realizar una cumbre mundial de temas relacionados con desarrollo de software, auspiciada por varios países. Nos piden desarrollar un modelo de objetos para manejar las registraciones de participantes, y las consecuencias de algunas actividades que se van a llevar a cabo.

Este modelo aplica a una sola cumbre, que por lo tanto se puede modelar como un objeto bien conocido.


## Participantes, conocimientos, ingresos, estadísticas

En esta primera etapa, debemos generar un primer modelo de la cumbre, y modelar países, conocimientos y participantes.

De cada **país** debemos registrar con qué otros países tiene conflictos. Para simplificar la codificación, se acepta que en los tests, los conflictos se registren "en los dos sentidos", p.ej.
```
coreaDelNorte.registrarConflicto(coreaDelSur)
coreaDelSur.registrarConflicto(coreaDelNorte)
```

Cada **conocimiento** se modela como un objeto bien conocido. Se brinda el archivo `conocimientos.wlk` donde están definidos los conocimientos que vamos a usar en este desarrollo.

De cada **participante** debemos registrar: de qué país es, con qué conocimientos cuenta, y cuántos commits tiene hechos en repositorios públicos.  
Vamos a contemplar dos tipos de participantes: **programadores** y **especialistas**.
Se dice que un programador _es cape_ si hizo más de 500 commits. Para un especialista, la condición es tener más de dos conocimientos.

Se pide armar un modelo que:
* permita consultar, dado un país, si _es conflictivo_ para la cumbre. La condición es que el país esté en conflicto con, al menos, uno de los países auspiciantes de la cumbre.  
P.ej. si entre los países auspiciantes está Corea del Norte, entonces Corea del Sur es conflictivo para la cumbre.

* permita _registrar el ingreso_ de una persona a la cumbre: simplemente, se agrega a la persona a una lista de personas que participan en la cumbre.

* a partir de esto, permita consultar para la cumbre: el conjunto de países de les participantes, la cantidad de participantes de un país, el país con más participantes, y el conjunto de participantes "extranjeros", o sea, que no son de un país auspiciante.

* también, poder consultar si la cumbre _es relevante_: la condición es que todes les participantes sean capes.

Como ejemplo, consideremos estas personas:
* Juana es programadora argentina con 600 commits, conoce sobre programación básica, CSS y HTML.
* Lucía es programadora brasileña con 800 commits, conoce sobre programación básica y bases de datos.
* Mariana es especialista argentina con 200 commits, conoce sobre programación básica, instalación Linux, objetos y diseño con objetos.
* Susana es especialista colombiana con 1500 commits, conoce sobre programación básica y objetos.  

Si se registra a Juana, Lucía y Mariana en la cumbre, entonces tenemos: países con participantes Argentina y Brasil, 2 participantes de Argentina y 1 de Brasil, país con más participantes Argentina, la cumbre es relevante (porque son las tres capas).  
Si agregamos a Susana, ahora los países con participantes son Argentina, Brasil y Colombia, el país con más participantes sigue siendo Argentina, ahora la cumbre no es relevante (porque Susana no es capa).

Armar tests que verifiquen estas condiciones, y también que Corea del Sur es conflictivo para la cumbre a partir del conflicto que tiene con Corea del Norte. Poner como países auspiciantes a Argentina, Colombia y Corea del Norte. Verificar también que la única participante extranjera es Lucía, dado que Brasil no es auspiciante. 


**¡OJO!**  
cada consulta que se piden respecto de la cumbre deben ser resuelta enviándole _un_ mensaje a la cumbre. P.ej. para saber el país con más participantes, la consulta debe ser algo así:
```
cumbre.paisConMasParticipantes()
```

## Condiciones de ingreso
En esta etapa, se agrega el análisis de los requisitos que debe cumplir una persona para poder participar de la cumbre.
 
Para todos los **participantes** se pide que entre sus conocimientos esté la programación básica.
* Para **programadores** se pide que además tenga, al menos, una cantidad de commits que se establece en la cumbre. En principio este valor es de 300, o sea, la condición adicional es que el programador tenga más de 300 commits. Pero este valor tiene que poder cambiarse enviándole un mensaje a la cumbre.

* Para **especialistas** se agregan dos condiciones. Una es que tenga, al menos, la cantidad de commits que se piden para un programador _menos 100_. P.ej., si a un programador se le piden más de 300 commits, entonces a un especialista se le piden más de 200. La otra condición es que tenga conocimientos sobre objetos.
 
Además, la **cumbre** restringe el acceso a las personas de países conflictivos, y también que haya más de 2 personas del mismo país, salvo para los países auspiciantes (que pueden tener todos los participantes que quieran).
  
> Si implementar esta última condición (la de más de 2 participantes del mismo país salvo auspiciantes) se complica, cambiarla por la siguiente: no puede haber más de 2 participantes "extranjeros", según lo que se definió en la primer etapa.  

Se pide agregar al modelo la posibilidad de
* preguntarle a un participante si _cumple con los requisitos_ de acceso a la cumbre. Acá evaluar solamente las condiciones del participante, o sea, no van las restricciones relacionadas con el país.
* preguntarle a la cumbre si un participante _tiene restringido el acceso_. Acá evaluar las restricciones relacionadas con el país.
* preguntarle a la cumbre si un participante _puede ingresar_. La condición es que el participante cumpla con los requisitos, y además no tenga restringido el acceso.
* indicarle a la cumbre a que _dé ingreso_ a un participante. Si el participante puede ingresar, entonces se registra el ingreso. Caso contrario, debe generarse un error.
* preguntarle a la cumbre si _es segura_. La condición es que todos los participantes registrados,  puedan ingresar (de acuerdo a las condiciones del participante y restricciones que pone la cumbre). 


## Actividades

Agregar el manejo de **actividades**. Cada actividad tiene un tema, que es uno de los conocimientos modelados; y lleva una cantidad de horas.

Para un participante, _hacer una actividad_ tiene dos consecuencias: el tema de la actividad se incorpora a los conocimientos que tiene, y se agrega una cantidad de commits que es el resultado de multiplicar los commits por hora asociados al tema, por la cantidad de horas de la actividad.  
P.ej. para una actividad sobre bases de datos que dura 3 horas, corresponde agregar 3 * 8 = 24 commits.
Para los **programadores** se agrega una tercer consecuencia: se suman las horas de la actividad a un total de horas de capacitación que hay que agregar al modelo de programadores.

Se pide agregar al modelo
* el registro de que una actividad se realiza en la cumbre. Esto implica: agregar la actividad a un conjunto de actividades realizadas que hay que agregar al modelo de la cumbre, e indicarle a cada participante que hizo la actividad, con las consecuencias indicadas más arriba.
* la consulta sobre el total de horas de actividades realizadas en la cumbre.


## Gerentes

Agregar al modelo un tercer tipo de participante, les **gerentes**. De cada gerente, se sabe (además de los datos comunes a todos los participantes) en qué empresa trabaja.  
A su vez, cada **empresa** está establecida en un conjunto de países, una empresa se considera _multinacional_ si está en al menos tres países.

Un gerente _es cape_ si la empresa en la que trabaja es multinacional.  
Como _requisito de acceso_, además del común a todos los participantes, se agrega que entre sus conocimientos esté el manejo de grupos.



 














