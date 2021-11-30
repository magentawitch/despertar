extends Node

export var path_al_diario: NodePath
onready var diario = get_node(path_al_diario) as Diario


func anotar(director: Director, detalles: Dictionary):
	diario.escribir_renglon(detalles['texto'])
	$"../../ui/menu/boton_abrir_diario/Notificacion".visible = true
	director.termino_la_ejecucion_de_la_accion()
