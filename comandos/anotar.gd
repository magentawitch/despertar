extends Node

export var path_al_diario: NodePath

func diario() -> Diario:
	return get_node(path_al_diario) as Diario

func anotar(director: Director, detalles: Dictionary):
	diario().escribir_renglon(detalles['texto'])
	director.termino_la_ejecucion_del_comando()
