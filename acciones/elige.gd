extends Node


const escena_dialogo = preload('res://herramientas/dialogo/cuadro_de_decision.tscn')

export var contenedor_del_dialogo: NodePath

func contenedor() -> Node2D:
	return get_node(contenedor_del_dialogo) as Node2D

func elige(director: Director, detalles: Dictionary):
	var dialogo = escena_dialogo.instance()
	for opcion in detalles['opciones']:
		dialogo.agregar_opcion(opcion[0], opcion[1])
	contenedor().add_child(dialogo)
	var opcion_elegida = yield(dialogo, "tomo_una_decision")
	dialogo.queue_free()
	detalles['responsable'].call(opcion_elegida)
	director.termino_la_ejecucion_de_la_accion()
