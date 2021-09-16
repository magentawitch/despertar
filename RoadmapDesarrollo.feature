Característica: Una forma de interactuar con el diario desde el código

  Escenario: Agregar eventos al diario [x]
  Escenario: Preguntar cuantas páginas del diario están ocupadas [x]
  Escenario: Obtener las entradas de la página $n del diario [x]
  Escenario: Falla al obtener una página inexistente [x]
  Escenario: Tiene que saberse cuanto de una página ocupa la entrada de un evento [x]


Característica: Una forma de visualizar las entradas del diario desde dentro del juego

  Escenario: Al abrirlo se muestra la última página [x]
  Escenario: Se pueden navegar las páginas [x]


Característica: Cola de acciones (Director)

  Escenario: Al encolar una accion y avanzar un step se ejecuta esa accion [x]
  Escenario: Al agregar dos acciones y avanzar dos steps las acciones se ejecutan en orden [x]
  Escenario: La accion recibe un mensaje cuando comienza la ejecución 
             de un step y responde avisando que terminó [x]
  Escenario: Tratar de avanzar un step mientras el anterior no termino es un error [x]
  Escenario: Si hay un step en ejecución se puede obtener la accion asociada [x]
  Escenario: Cuando se termine de ejecutar una accion y inmediatamente comienza la
             ejecución del siguiente [x]
  Escenario: Salvo que esté pausado [x]


Característica: Interactuar con el diario con acciones

  Escenario: Al ejecutar la accion Anotar se agrega una entrada de texto en el diario [x]
  Escenario: Al ejecutar la accion AbrirDiario se abre el diario [x]
  Escenario: Al cerrar un diario abierto por AbrirDiario se termina el step [x]


Característica: Los personajes se pueden mover entre regiones

  Escenario: Al abrir la pantalla principal se carga en la region actual [x]
  Escenario: Al ejecutar la accion ViajarA el protagonista puede cambiar la region actual [ ]
  Escenario: Al cambiar de región se descarga la actual y se carga la nueva [ ]
  Escenario: Al hacer click en puertas se encola 'ViajarA la región de destino' [ ]
  Escenario: No se puede hacer click en puertas se hay se está ejecutando un step [ ]
  Escenario: Cuando el personaje viene de una región $r aparece en el origen
             para la misma (usualmente al lado de la puerta que lleva de regreso a $r) [ ]


Característica: Los personajes pueden hablar
  
  Escenario: Al ejecutar la accion 'Decir un texto' se muestra un cuadro con el
             texto y el recuadro del personaje que habló [ ]
  Escenario: Al ejecutar la accion 'Decir un texto' se muestra un globo con el
             texto arriba del personaje [ ]
  Escenario: Al hacer click en cualquier lado se termina el step [ ]


Característica: Entradas de diario con fotos epigrafeables

  Escenario: Al agregarla se visualiza el diario con la foto y un prompt para el epigrafe [ ]
  Escenario: Al elegir el epigrafe se agrega la entrada en el diario y se muestra
             el diario en la última página [ ]
  Escenario: Al salir del diario se reanuda la partida [ ]


Característica: Los personajes se pueden mover por dentro de una región

  Escenario: Al ejecutar la accion 'CaminarHacia una posición' el protagonista se mueve a esa posición [ ]
  Escenario: Al hacer click sobre un area en la pantalla se encola 'CaminarHacia la posición del click' [ ]
  Escenario: No se puede hacer click si hay se está ejecutando un step [ ]


Característica: Las colas de acciones pertenecen a estados de una FSM con pila 

  Cada estado tiene la oportunidad de definir sus propias reglas y sus propias acciones
  Hay un par de acciones especiales para manipular la pila (Peek, Push, Pop y Swap)
  Al pushear un estado nuevo en la pila pausa la ejecución de las acciones del
  estado anterior hasta que este vuelva a ser el tope de la pila
  Escenario: ???+++>>> Analizar cuales serian los casos de uso de esto [ ]


Característica: Interface DSL-ish para scripting de escenas
Característica: Persistencia (diario, region, posición) 

