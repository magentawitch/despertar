extends Node

export(NodePath) var path_al_contenedor_de_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_escena) as ContenedorDeEscena


func cambio_de_escena(director: Director, detalles: Dictionary) -> void:
	var nombre_de_la_escena_a_la_que_cambia = detalles['escena']
	contenedor_de_escena.cambiar_escena(nombre_de_la_escena_a_la_que_cambia)
	yield(contenedor_de_escena, "una_escena_fue_cargada")
	director.termino_la_ejecucion_de_la_accion()
	
