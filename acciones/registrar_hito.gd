extends Node


export var path_al_diario: NodePath
onready var diario = get_node(path_al_diario) as Diario

func registrar_hito(director: Director, detalles: Dictionary):
	diario.registrar_hito(detalles["nombre_hito"])
	director.termino_la_ejecucion_de_la_accion()
