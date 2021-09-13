Característica: Una forma de interactuar con el diario desde el código

  Escenario: Agregar eventos al diario [x]
  Escenario: Preguntar cuantas páginas del diario están ocupadas [x]
  Escenario: Obtener las entradas de la página $n del diario [x]
  Escenario: Falla al obtener una página inexistente [x]
  Escenario: Tiene que saberse cuanto de una página ocupa la entrada de un evento [x]


Característica: Una forma de visualizar las entradas del diario desde dentro del juego

  Escenario: Al abrirlo se muestra la última página [x]
  Escenario: Se pueden navegar las páginas [x]


Característica: Cola de comandos

  Escenario: Al encolar un comando y avanzar un step se ejecuta ese comando [x]
  Escenario: Al agregar dos comandos y avanzar dos steps los comandos se ejecutan en orden [x]
  Escenario: El comando recibe un mensaje cuando comienza la ejecución 
             de un step y responde avisando que terminó [x]
  Escenario: Tratar de avanzar un step mientras el anterior no termino es un error [x]
  Escenario: Si hay un step en ejecución se puede obtener el comando asociado [x]
  Escenario: Cuando se termine de ejecutar un comando y inmediatamente comienza la
             ejecución del siguiente [x]
  Escenario: Salvo que esté pausado [x]


Característica: Interactuar con el diario con comandos

  Escenario: Al ejecutar el comando Anotar se agrega una entrada de texto en el diario [ ]
  Escenario: Al ejecutar el comando AbrirDiario se abre el diario [ ]
  Escenario: Al cerrar un diario abierto por AbrirDiario se termina el step [ ]


Característica: Los personajes se pueden mover entre regiones

  Escenario: Al ejecutar el comando ViajarA el protagonista puede cambiar de region [ ]
  Escenario: Al hacer click en puertas se encola 'ViajarA la región de destino' [ ]
  Escenario: No se puede hacer click en puertas se hay se está ejecutando un step [ ]
  Escenario: Cuando el personaje viene de una región $r aparece en el origen
             para la misma (usualmente al lado de la puerta que lleva de regreso a $r) [ ]


Característica: Los personajes pueden hablar
  
  Escenario: Al ejecutar el comando 'Decir un texto' se muestra un cuadro con el
             texto y el recuadro del personaje que habló [ ]
  Escenario: Al ejecutar el comando 'Decir un texto' se muestra un globo con el
             texto arriba del personaje [ ]
  Escenario: Al hacer click en cualquier lado se termina el step [ ]


Característica: Entradas de diario con fotos epigrafeables

  Escenario: Al agregarla se visualiza el diario con la foto y un prompt para el epigrafe [ ]
  Escenario: Al elegir el epigrafe se agrega la entrada en el diario y se muestra
             el diario en la última página [ ]
  Escenario: Al salir del diario se reanuda la partida [ ]


Característica: Los personajes se pueden mover por dentro de una región

  Escenario: Al ejecutar el comando 'CaminarHacia una posición' el protagonista se mueve a esa posición [ ]
  Escenario: Al hacer click sobre un area en la pantalla se encola 'CaminarHacia la posición del click' [ ]
  Escenario: No se puede hacer click si hay se está ejecutando un step [ ]


Característica: Las colas de comandos pertenecen a estados de una FSM con pila 

  Cada estado tiene la oportunidad de definir sus propias reglas y sus propios comandos
  Hay un par de comandos especiales para manipular la pila (Peek, Push, Pop y Swap)
  Al pushear un estado nuevo en la pila pausa la ejecución de los comandos del
  estado anterior hasta que este vuelva a ser el tope de la pila
  Escenario: ???+++>>> Analizar cuales serian los casos de uso de esto [ ]


Característica: Interface DSL-ish para scripting de escenas
Característica: Persistencia (diario, region, posición) 

