# Clean Architecture



## ¿Qué propone?
### Gritando la arquitectura
 
Robert Martin, más conocido como Tío Bob (Uncle Bob en inglés), plantea que la arquitectura de un software debe gritar cuál es el uso de dicho software. Así como al ver planos de edificios, si uno ve que el edificio posee un baño, cocina, comedor, dormitorios, la arquitectura grita que es una casa familiar. De esta manera, al visualizar la arquitectura de un software, se debería notar cual es el uso del mismo. La arquitectura no debería indicar cuál es el framework o herramientas usadas para su construcción.

Volviendo al arquitecto de edificios, el mismo se asegura que un edificio cumpla con los casos de uso antes de decidir qué materiales se usarían para su construcción. En el caso del desarrollo de software, cumplimentar esto, asegura que el producto satisfaga los casos de uso y retrase la decisión sobre los frameworks o herramientas a usar. Incluso, una buena arquitectura basada en casos de usos permite que sea fácil cambiar la herramienta que se va a usar.

---

### La arquitectura limpia
![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean1.png)


La propuesta del Tío Bob sobre la arquitectura limpia impone las siguientes restricciones:

- **Independente de frameworks:** la arquitectura no debe atarse a las restricciones del framework. Esto permite considerar al framework como una herramienta.

- **Testeable:** las reglas de negocios deberían poder probarse independientemente de la UI, base de datos u otras herramientas.

- **Independiente de la UI:** la interfaz de usuario se debería poder cambiar fácilmente sin necesidad de cambiar la lógica de negocio.

- **Independiente de la base de datos:** las reglas de negocios no deberían estar ligadas a la base de datos o herramienta de persistencia.

---

#### La regla de la dependencia
El diagrama presenta una arquitectura basada en “capas de cebolla”, enfoque propuesto por Jeffrey Palermo. Cada círculo concéntrico representa aspectos diferentes del software. Las capas exteriores dependen de las interiores. Pero no debería ocurrir el caso inverso, los círculos interiores no debe saber nada de los exteriores.

Incluso la base de datos es externa, rompiendo con la idea de “aplicaciones de base de datos” o modelos altamente ligados a la herramienta de base de datos.

---

#### Entidades
Encapsulan la lógica de negocio de la empresa. Una entidad puede ser un objeto con métodos, o puede ser un conjunto de estructuras de datos y funciones. Encapsulan la mayoría de la lógica general y de alto nivel; y deberían poder reutilizarse en las diferentes aplicaciones de la empresa. Las entidades deberían ser las menos propensas a sufrir cambios debidos a un cambio externo. Por ejemplo, no se espera un cambio en las entidades habiendo modificado algún aspecto de la UI o la seguridad. Ningún cambio operacional de una aplicación particular debería afectar a la capa de entidades.

---

#### Casos de uso
Esta capa contiene las reglas de negocio específicas de la aplicación. Encapsula e implementa todos los casos de uso del sistema. Éstos dirigen el flujo de datos hacia y desde las entidades y hacen que las entidades usen su lógica de negocio para conseguir el objetivo del caso de uso. Los cambios en esta capa no deberían afectar a las entidades. Tampoco se espera que cambios externos como en la base de datos, framework o la interfaz gráfica afecten a esta capa. Sin embargo, sí se esperan cambios en las operaciones de la aplicación afecten a los casos de uso. Es decir, si detalles de un caso de uso cambian, entonces algo de código de esta capa va a cambiar.

---

#### Adaptadores de interfaz
Esta capa contiene un conjunto de adaptadores que convierten los datos desde el formato más conveniente para el caso de uso y entidades al formato más conveniente o aceptado por elementos externos como la base de datos o la UI. Los presentadores, vistas y controladores pertenecen a esta capa. Los modelos son sólo estructuras que se pasan desde los controladores a los casos de uso y de vuelta desde los casos de uso a los presentadores y/o vistas. Del mismo modo, los datos son convertidos en esta capa, desde la forma de las entidades y casos de uso a la forma conveniente para la herramienta de persistencia de datos.

En este círculo se encuentran también los demás adaptadores encargados de convertir datos obtenidos de una fuente externa, como un servicio externo, al formato interno usado por los casos de uso y las entidades.

---

#### Frameworks y drivers
El círculo más externo se compone generalmente de frameworks y herramientas como la base de datos, el framework web, etc. Generalmente en esta capa sólo se escribe código que actúa de “pegamento” con los círculos interiores. En esta capa es donde van todos los detalles. La web es un detalle. La base de datos es un detalle. Se mantienen estas cosas afuera, donde no pueden hacer mucho daño.

---

#### Cruzando la frontera

En el gráfico se ve un ejemplo de cómo se cruzan las fronteras del círculo. Muestra cómo los controladores y presentadores se comunican con los casos de uso del círculo interno. El control del flujo empieza en el controlador, atraviesa el caso de uso y finaliza en el presentador. La dependencia a nivel de código fuente apunta hacia adentro, hacia los casos de uso. Se resuelve esta supuesta contradicción usando el principio de inversión de dependencia, es decir, desarrollando interfaces y relaciones de herencia de tal manera que las dependencias de código fuente se oponen al flujo de control en sólo algunos puntos a través de la frontera.

<div><img src="https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean2.png" ></div>

Considerando que los casos de uso necesitan llamar al presentador, esta llamada no debe ser directa ya que se violaría el principio de la regla de dependencia. Ninguna implementación de un círculo exterior puede ser llamado por un círculo interior. En esta situación el caso de uso llama a una interfaz definida en el círculo interno y hace que el presentador implemente dicha interfaz en el círculo exterior.

---

#### Los datos que cruzan la frontera

Las estructuras de datos que se pasan a través de las fronteras deben ser simples. No se debería pasar entidades o filas de base de datos. Muchos frameworks de base de datos devuelve los datos en el formato de respuesta de una query. Por ejemplo, un RowStructure. Pasar los datos en ese formato violaría la regla de dependencia obligando a un círculo interno saber algo sobre un círculo exterior. Las estructuras de datos que tienen cualquier tipo de dependencia con capas exteriores viola la regla de dependencia. 

Los datos que cruzan las fronteras deben ser estructuras de datos simples. Se puede utilizar estructuras básicas u objetos Data Transfer. O los datos pueden ser argumentos en las llamadas a funciones. O bien, almacenar en un diccionario o hash. Cuando se pasan datos a través de una frontera, siempre debe ser en la forma más conveniente para el círculo interior.

---

## Diferencias con patrón arquitectónico MVC

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean3.png)

El patrón MVC distingue 3 componentes:
- **Modelo:** es el software del dominio de la aplicación, contiene la lógica del negocio.
- **Controlador:** contiene las interfaces que asocia el modelo, las vistas y los dispositivos de entrada.
- **Vista:** Muestra los datos del modelo y refleja sus cambios.

Este patrón considera la presencia de una única vista o controlador. Lo que ocurre cuando hay múltiples vistas es lo siguiente:

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean4.png)

En la mayoría de los frameworks de UI actuales, especialmente los de aplicaciones móviles, los componentes de las vistas suelen ser también controladores, por ejemplo, un botón “virtual”, siendo difícil aplicar el patrón MVC tal como fue concebido en sus orígenes.

También se nota la ausencia de especificación del almacenamiento de los datos del modelo o interacción con otros servicios como internet, aspectos muy recurrentes en aplicaciones modernas.
Este patrón es relativamente sencillo, siendo que en la actualidad no sea muy útil su uso para arquitectura de aplicaciones.

Sin embargo, el patrón MVC o similares sigue siendo usado para el manejo de la vista y los eventos, por lo que se puede seguir usando dentro de la capa de presentación de las aplicaciones.

---

## Relación con patrón Layers

Como se mencionó anteriormente, Clean Architecture está basada en capas en formas de “aros de cebolla”. Dada la restricción de la regla de la dependencia, se puede relacionar cada capa de la arquitectura propuesta con cada capa del patrón arquitectónico Layers.

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean5.png)

---

## Experiencia en el desarrollo de aplicaciones móviles

Las aplicaciones móviles poseen muchas limitaciones inherentes a la plataforma comparado con una computadora de escritorio, como la limitación energética, acceso a internet escaso, pantalla reducida. Sin embargo, el aumento de las especificaciones técnicas de los equipos como de la calidad del servicio de internet móvil ha posibilitado el crecimiento en funcionalidad de las aplicaciones móviles, con su consecuente crecimiento en cantidad y complejidad del código. Además, la frecuencia con la que se actualizan los sistemas operativos móviles y los frameworks de desarrollo es vertiginosa.
Esta situación obliga a tener un mayor compromiso en el diseño de la arquitectura para que la misma posibilite un buen rendimiento general, como también que sea fácil de mantener por parte de los desarrolladores.

El patrón arquitectónico más primitivo para el desarrollo de aplicaciones con interfaces gráficas es el patrón MVC. Sin embargo, en las aplicaciones modernas (incluyendo las de escritorio) hay un alto acoplamiento entre la vista y el controlador. Lo sugerente es que Apple promueve el uso de MVC, disponiendo una clase llamada ViewController, generando el acoplamiento de la vista y el controlador en una única clase, efecto que los desarrolladores han llamado Massive View Controller.

Hay muchas variantes alternativas, entre ellas MVP y MVVM. Incluso existe librerías de programación reactiva. Sin embargo, sus diseños e implementaciones siguen siendo acotados y no cubren varios aspectos.

Debido a que las aplicaciones móviles hace uso de internet y a que el mismo es intermitente, es imperante la interacción con servicios externos y la persistencia de los datos en el dispositivo, elementos que ninguno de los patrones mencionados contempla. Que un patrón de arquitectura no contemple dichas situaciones da origen a problemas como llamadas a un servicio web o acceso a base de datos directamente desde las clases de la vista o el presentador, afectando a la mantenibilidad del código a futuro.

El criterio de Clean Architecture parece adecuado para resolver los problemas planteados a pesar de que no se tiene constancia de uso de este criterio en alguna aplicación conocida. Sin embargo ha surgido material que propone ideas para su implementación.
Tanto para Android como iOS, la comunidad de desarrolladores han realizado diversas propuestas de la implementación de Clean Architecture.
Google dispone de un repositorio en GitHub que contiene ejemplos de arquitectura para aplicaciones Android. Uno de los ejemplos consta de una posible implementación de Clean Architecture.
Apple no ha provisto información sobre la arquitectura de aplicaciones iOS.

---

## Una propuesta de Clean Architecture

Una propuesta tradicional, pero adaptada para aplicaciones móviles, es la de Fernando Cejas, desarrollador de Android. Su propuesta es dividir el proyecto de la aplicación en 3 grandes capas (layers), cada una con propósitos diferentes y que funcionan separadas de las demás. Incluso hace mención a que cada capa tiene su propio modelo de datos para alcanzar la independencia entre ellas.

El esquema propuesto es el que se muestra a continuación:

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean6.png)

Sin embargo, esta separación en capas es más bien conceptual. Es decir, los elementos de cada capa no estarán separados mediante un facade, ni siquiera separados físicamente en directorios diferentes. Esto es así porque, si se clasificaran los archivos según su tipo, regresaría una de las problemáticas que ataca Clean Architecture: que la arquitectura no “grite” lo que hace.

Además, cada pantalla de una aplicación móvil, por lo general, responde a un caso de uso particular. Siendo natural en el desarrollo móvil agrupar los archivos relacionados a cada pantalla, se propone incluir los interactores de casos de usos junto con los correspondientes archivos de la capa de presentación.


La organización de los archivos propuesta para proyectos móviles es la siguiente:

- **Models:** Contienen los archivos de las entidades de la lógica de negocio (capa de dominio)
- **Services:** Implementaciones de los workers y servicios de la capa de datos
 - **Store:** herramientas y elementos para almacenar las entidades del dominio en una base de datos u otra forma de persistencia local
 - **Network:** herramientas y elementos para conectarse a una API o cualquier recurso de Internet
- **Workers:** Generalmente contiene, para cada elemento del modelo, una interfaz que define las operaciones para obtener, crear, modificar y/o eliminar los elementos del modelo en la capa de datos. Son interfaces que forman parte de la capa de dominio y se definen para que las implementen los distintos servicios
- **Scenes:** Elementos relacionados con la capa de presentación
 - **UseCase:** Elementos del caso de uso en cuestión
  - **Interactor:** Elemento que contienen las reglas de negocio del caso de uso en cuestión (capa de dominio)
  - **Presenter:** Elemento que adapta los modelos del dominio para presentarlos a la vista
  - **View:** Elementos de la vista
  - **Worker:** Elemento que obtiene los datos que solicita el interactor (capa de datos)
  - **Router:** Elemento que contiene la lógica de navegación entre las vistas, realizando las configuraciones necesarias como pasar datos, establecer valores necesarios al inicio, etc.

---

### Capa de dominio

Esta capa contiene todas las entidades y reglas de negocio (casos de usos). Contiene también las implementaciones de los interactores.

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean7.png)

Esta capa debe estar escrito en el lenguaje puro de la plataforma, sin ninguna dependencia con el SDK o UI.

Todos los componentes externos utilizan interfaces para conectarse con los objetos de negocio.

---

### Capa de presentación
Contiene la lógica relacionada con las vistas y animaciones. Se puede usar Modelo Vista Presentador (MVP) o cualquier otro patrón de vista como MVC o MVVM. No hay lógica en esta capa, excepto la de interfaz de usuario.

Para esta capa se propone utilizar una idea de Raymond Law, que consiste en diseñar la presentación como un ciclo, llamado VIP, el cual tiene un diseño que se acerca al propuesto por el Tío Bob sobre la interacción entre elementos de la frontera de 2 capas (en este caso, capa de dominio con la capa de presentación).

Los elementos del ciclo VIP se relacionan de la siguiente manera

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean8.png)

Se trata de un ciclo unidireccional, es decir, la salida de la vista se comunica con la entrada del interactor; la salida del interactor se comunica con la entrada del presentador; la salida del presentador se comunica con la entrada de la vista.

Pero recordemos que el interactor es parte de la capa de dominio, no debería llamar directamente al presentador, el cual forma parte de la capa de presentación. Para ello se diseñan las interfaces adecuadas para que se respete la regla de dependencia de Clean Architecture.

Las llamadas realizadas desde la vista no deben ser bloqueantes, para evitar afectar el rendimiento de la aplicación.
Cualquier operación bloqueante que realice el interactor u otro elemento deben realizarse en otro thread. 

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean9.png)

---

### Capa de datos
Todos los datos necesarios para la aplicación provienen de esta capa a través de una implementación de la interfaz que se encuentra en la capa de dominio. Utiliza un patrón de repositorio con una estrategia de elegir diferentes fuentes de datos en función de ciertas condiciones.

Por ejemplo, cuando se desea conseguir un usuario por ID, se selecciona la fuente de datos de caché de disco, si el usuario ya existe en la caché, de lo contrario se consultará en la nube para recuperar los datos y luego guardarlo en la memoria caché de disco.

La idea detrás de todo esto es que el origen de datos es transparente para el cliente, no le interesa si los datos provienen de memoria, disco o la nube, la única verdad es que los datos llegarán y serán conseguidos.

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean10.png)

Una propuesta, ya adelantada en la estructura de directorios del proyecto, es definir para cada elemento del dominio una interfaz de un repositorio para esa entidad y que en el directorio de servicios se implemente.

---

### Manejo de errores
Hay 2 enfoques posibles. Por un lado se pueden usar callbacks para la respuesta del repositorio de datos, por ejemplo, el callback puede contener 2 métodos: onResponse() y onError(). La última debe encapsular las excepciones en una clase contenedora. Este enfoque tiene algunas dificultades porque causan cadenas de callbacks hasta que el error llegue a la capa de presentación para ser presentados. La legibilidad del código puede ser afectada.
Otro enfoque es implementar un sistema de bus de eventos que lanza eventos si algo ocurre algo no deseado, pero este tipo de solución es como usar un GOTO.

---

### Recapitulando, interacción global

A continuación se muestra un gráfico más integrador sobre cómo interactúan los elementos descripto anteriormente.

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean11.png)

Acomodando los elementos en las capas propuestas inicialmente, resulta el siguiente esquema.

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean12.png)

---

## Una mirada práctica de Clean Architecture

*FIUBA desea construir un sistema que permita, para un cuatrimestre dado, enumerar los cursos ofrecidos por materia y permitir la inscripción a los cursos. El alumno no puede inscribirse a más de 7 cursos por cuatrimestre.*

## Casos de usos identificados

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/clean13.png)

## Mockup de la aplicación

![arquitectura limpia](https://github.com/ezeperez26/clean-architecture/blob/master/resources/BalsamiqMockup.png)

---

## Aclaraciones sobre la implementación

Por lo general, este tipo de aplicaciones suelen comunicarse con un servicio web, estando toda la lógica de negocio fuera de la aplicación móvil. A modo de ejemplo, se prescindió del desarrollo de un servicio web y se incluyó la lógica en la aplicación móvil. Los datos de las asignaturas y cursos son provistos mediante un JSON estático y luego son almacenados los cambios localmente, en una base de datos.

Según la consigna, la cantidad máxima de cursos en que un alumno se puede inscribir es 7. Debido a que la cantidad de asignaturas provistas por las aplicaciones implementadas es menor, se redujo el límite de inscripciones a un valor en el cual se pueda mostrar ejemplificar la situación del caso de uso correspondiente. 

---

## Conclusión
Inicialmente la experiencia nos indicó que había que escribir mucho código, aún para vistas y casos de usos relativamente sencillos. Sin embargo, tener bien definida la responsabilidad de cada elemento, el desarrollo y los cambios se pueden hacer de forma incremental. Por ejemplo, desarrollar bien el caso de uso y luego la vista (o viceversa, situación común en el desarrollo de aplicaciones móviles). Además, el rendimiento de la aplicación no ha sido afectada a pesar de que se instancian muchos objetos por cada caso de uso implementado. De todas maneras, recordemos que la aplicación de ejemplo es relativamente simple y no tiene interacción con Internet, una de las operaciones más lentas.

Aún nos queda definir bien cómo manejar los errores, detalle que tampoco ha sido expuesto con claridad por las propuestas actuales de la comunidad de desarrolladores. El problema que nos hemos encontrado en este apartado es que la capa de presentación está totalmente aislada de la capa de datos (lugar común donde ocurren errores, ya sea por falta de internet, timeout, etc) y la capa de dominio no debería manejar los errores, ya que incluiría elementos del SDK de la plataforma en que se desarrolla.

Como conclusión, la propuesta expuesta en el presente trabajo es un buen puntapié para seguir refinando la idea de Clean Architecture en base a la experiencia de desarrollo y la participación de la comunidad de desarrolladores.

---

## Bibliografía
CEJAS, F. (2014). Architecting Android…The clean way?. Fernando Cejas Blog.
	[http://fernandocejas.com/2014/09/03/architecting-android-the-clean-way](http://fernandocejas.com/2014/09/03/architecting-android-the-clean-way/>)

GOOGLE (2016). Android Architecture Blueprints [beta]. GitHub.
[https://github.com/googlesamples/android-architecture](https://github.com/googlesamples/android-architecture)

KRASNER, G. E., POPE, S. T. (1988). A Description of the Model-View-Controller User Interface Paradigm in the Smalltalk-80 System. ParcPlace Systems, Inc.  
	[http://web.archive.org/web/20150117044636/http://www.itu.dk/courses/VOP/E2005/VOP2005E/8_mvc_krasner_and_pope.pdf](http://web.archive.org/web/20150117044636/http://www.itu.dk/courses/VOP/E2005/VOP2005E/8_mvc_krasner_and_pope.pdf)

LAW, R. (2015). Clean Swift iOS Architecture for Fixing Massive View Controller. Clean Swift.  
[http://clean-swift.com/clean-swift-ios-architecture/](http://clean-swift.com/clean-swift-ios-architecture/)

MARTIN, R. (2011). Screaming Architecture. 8th Light Blog.  
[http://blog.8thlight.com/uncle-bob/2011/09/30/Screaming-Architecture.html](http://blog.8thlight.com/uncle-bob/2011/09/30/Screaming-Architecture.html)

MARTIN, R. (2011). Architecture the Lost Years. Ruby Midwest 2011.  
[https://www.youtube.com/watch?v=WpkDN78P884](https://www.youtube.com/watch?v=WpkDN78P884)

MARTIN, R. (2012). The Clean Architecture. 8th Light Blog.  
[https://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html](https://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html)

MARTIN, R. (2012). Clean Architecture. NDC Conferences.  
[https://vimeo.com/43612849](https://vimeo.com/43612849)

PALERMO, J. (2008). The Onion Architecture. Part I. Jeffrey Palermo Blog.  
[http://jeffreypalermo.com/blog/the-onion-architecture-part-1/](http://jeffreypalermo.com/blog/the-onion-architecture-part-1/)

