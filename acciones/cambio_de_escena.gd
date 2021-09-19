extends Node

export var path_al_contenedor_de_la_escena: NodePath

func contenedor() -> Node2D:
	return get_node(path_al_contenedor_de_la_escena) as Node2D

func cambio_de_escena(director: Director, detalles: Dictionary) -> void:
	var nombre_de_la_escena_a_la_que_cambia = detalles['escena']
	contenedor().cambiar_escena(nombre_de_la_escena_a_la_que_cambia)
	yield(contenedor(), "la_escena_fue_cambiada")
	director.termino_la_ejecucion_de_la_accion()
