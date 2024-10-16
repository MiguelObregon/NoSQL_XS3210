I. INTRODUCCIÓN

  En la actualidad, el uso eficiente de las tecnologías de datos es esencial en un mundo donde la conectividad es inmediata y accesible con solo unos clics. Sin embargo, la falta de estas herramientas puede obstaculizar una toma de decisiones informada. Un claro ejemplo de ello es el modelo SQL, que ha revolucionado la programación desde 1970, permitiendo un manejo avanzado de bases de datos basado en principios ACID, que aseguran la integridad y seguridad de la información.

  Por otro lado, las bases de datos NoSQL se destacan por su flexibilidad y características que los sistemas relacionales no pueden ofrecer. Estas bases no están obligadas a cumplir con las propiedades ACID, lo que elimina la necesidad de seguir estrictamente el álgebra relacional. La elección entre estos tipos de bases depende de la naturaleza de los datos y los requisitos de procesamiento. Este trabajo tiene como objetivo comparar las implementaciones de bases de datos NoSQL mediante dos sistemas de almacenamiento.

  La comparación se centrará en las bases de datos de tipo documento, que están diseñadas para ofrecer un alto rendimiento y ser adecuadas para el manejo de grandes volúmenes de datos. En el siguiente repositorio de GitHub se encuentran los archivos de datos utilizados, así como el código para generarlos y archivos PDF con instrucciones para instalar los programas, crear bases de datos e importar datos.

II. PLANTEAMIENTO DEL PROBLEMA

  El Servicio de Odontología del Área de Salud Alajuela Norte enfrenta desafíos en la gestión eficaz de sus actividades cotidianas. Las dificultades con las citas perdidas, las sustituciones de pacientes y la utilización ineficiente de horas en consultas externas y procedimientos resultan en un uso ineficiente de los recursos y en una menor satisfacción del paciente. La falta de una herramienta que centralice la información sobre citas y ausencias complica aún más la toma de decisiones. Por lo tanto, implementar una base de datos de tipo documento puede facilitar el almacenamiento y la gestión de esta información, mejorando el control sobre los recursos y la programación de citas.

III. PROCESO DE SOLUCIÓN IMPLEMENTADA

  Para abordar este problema, se propuso desarrollar una base de datos no estructurada que optimice la velocidad de lectura y escritura de datos masivos, ideal para el seguimiento de inasistencias y citas sustituidas. Este enfoque permite la flexibilidad en la estructura de datos, facilitando la adición o modificación de campos sin la necesidad de reestructurar toda la base. Además, al almacenar la información en un solo documento, se reducen las consultas complejas y se mejora la manejabilidad. Este sistema también permite una escalabilidad horizontal, facilitando el manejo de grandes volúmenes de datos y consultas distribuidas, como el historial de citas y consultas de pacientes.

  La construcción de esta base de datos se realizó en dos plataformas diferentes que utilizan bases de datos de tipo documento: CouchDB y RavenDB. CouchDB fue elegido por su capacidad para almacenar y recopilar datos sin un esquema rígido, simplificando así la gestión de registros. Por su parte, RavenDB se seleccionó por su uso de motores que optimizan la rapidez y eficiencia de las consultas, además de facilitar la manipulación y extracción de datos de forma intuitiva.

  Se codificaron 400 documentos, distribuidos equitativamente entre citas, pacientes, inasistencias y sustituciones. Para estandarizar las propiedades, se utilizó un identificador común en todos los documentos, el cual fue añadido como “tipo_documento”. En ambos software, se demostró que las bases de datos de tipo documento son una solución efectiva para el problema planteado, aunque CouchDB mostró una ligera ventaja en la inserción de datos JSON, a pesar de requerir el uso de la línea de comandos para grandes volúmenes.

IV. COMPARACIÓN ENTRE COUCHDB Y RAVENDB

A continuación, se analizarán las similitudes y diferencias entre CouchDB y RavenDB basándose en varios criterios.

A. Consistencia

  CouchDB utiliza un modelo de consistencia eventual, en el que los cambios en un nodo no se reflejan inmediatamente en todos los nodos, sino que se propagan con el tiempo. Este enfoque favorece la disponibilidad sobre la consistencia inmediata, alineándose con el teorema CAP (Consistencia, Disponibilidad y Tolerancia a Particiones). Para manejar actualizaciones concurrentes, CouchDB implementa el control de concurrencia multiversión (MVCC), que permite modificar documentos sin bloqueos, aunque requiere que los conflictos se gestionen manualmente.

  Las propiedades ACID en CouchDB se aplican a nivel de documento individual, asegurando que las operaciones sean atómicas y consistentes. En contraste, RavenDB ofrece flexibilidad al permitir configuraciones de consistencia tanto eventual como fuerte, lo que resulta ventajoso en aplicaciones que requieren diferentes niveles de coherencia. Sus consultas se gestionan a través de un almacén de índices, permitiendo que las consultas sean rápidas, aunque pueden acceder a datos desactualizados si la sincronización aún no se ha completado. RavenDB también permite a los usuarios ajustar el nivel de consistencia según las necesidades de la operación. La opción de consistencia fuerte asegura que los datos se reflejen inmediatamente en todos los nodos, lo cual es crítico en aplicaciones donde la precisión de los datos es primordial.

B. Inserción de datos

  A pesar de que ambas bases trabajan con documentos JSON, el método de inserción de datos varía. CouchDB permite la inserción uno a uno a través de su interfaz gráfica, lo cual es poco práctico para bases de datos grandes. Para una inserción masiva, es necesario utilizar la línea de comandos y proporcionar un archivo JSON estructurado como un arreglo de documentos. Si los documentos tienen diferentes tipos, es recomendable incluir un identificador que los distinga. Por su parte, en RavenDB, aunque también se puede crear documentos individualmente, esta opción se vuelve ineficaz para bases grandes. Se permiten inserciones a partir de archivos CSV, pero no existe una opción directa para cargar documentos JSON en masa, lo que puede complicar el proceso.

C. Recuperación de datos

  CouchDB destaca por su replicación bidireccional, ideal para aplicaciones distribuidas y móviles, ya que permite mantener los datos actualizados incluso cuando están offline. Esta característica facilita la recuperación de datos sin pérdidas en caso de fallos. RavenDB, en cambio, cuenta con un robusto sistema de respaldos que permite restaurar la base de datos tras un fallo. Ofrece opciones para planes automáticos de respaldo, asegurando que los datos estén siempre listos para una recuperación rápida.

D. Facilidad de uso

  CouchDB tiene una interfaz amigable que permite a los usuarios gestionar documentos fácilmente una vez que se ingresan los datos. La estructura permite agregar o eliminar elementos sin afectar a otros documentos, a diferencia de los modelos relacionales. RavenDB presenta una interfaz moderna que facilita la visualización y edición de documentos. Su capacidad para gestionar la inserción de documentos sin necesidad de utilizar comandos complejos lo hace accesible para usuarios menos técnicos.

E. Herramientas de gestión

  CouchDB incluye Fauxton, una herramienta que permite crear, actualizar, eliminar y visualizar documentos, así como gestionar la replicación y configuraciones. Esta interfaz también permite un mejor control y seguridad sobre la base de datos. RavenDB, por su parte, ofrece una potente herramienta de gestión a través de su interfaz de administración, que permite monitorizar métricas operacionales y de rendimiento, brindando una vista clara del uso de recursos.

F. Método utilizado para hacer consultas

  En CouchDB, las consultas pueden realizarse mediante vistas o Mango Query. Las vistas permiten filtrar documentos para extraer información relevante, pero su implementación requiere el uso del cmd, lo que puede ser menos práctico a nivel visual para algunos usuarios. Por otro lado, Mango Query es un lenguaje propio de CouchDB que permite ejecutar consultas y ver resultados directamente en la interfaz de Fauxton, lo que facilita la visualización rápida. Aunque Mango Query tiene similitudes con SQL, su sintaxis es diferente y requiere aprendizaje. Las consultas en este caso fueron simples, pero en situaciones más complejas podrían requerir mayor esfuerzo de implementación.

G. Almacenamiento

  El uso del formato JSON (clave-valor) es fundamental, dado que es ligero y fácil de interpretar. CouchDB crea una nueva versión de cada documento al actualizarlo, mientras que RavenDB no crea revisiones nativas, pero mantiene la coherencia de los datos para transacciones ACID. CouchDB carece de una opción simple para exportar datos, confiando en la replicación, mientras que RavenDB permite exportar y respaldar datos, lo que facilita la recuperación y migración. 
