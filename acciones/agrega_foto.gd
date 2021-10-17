extends Node

export var path_al_diario: NodePath

func diario() -> Diario:
	return get_node(path_al_diario) as Diario

func agrega_foto(director: Director, detalles: Dictionary):
	diario().agregar_foto(detalles['escena_foto'])
	director.termino_la_ejecucion_de_la_accion()
