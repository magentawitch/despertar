extends Node

# TODO: Cambiar nombre de la accion a indicativo

export var path_al_diario: NodePath
onready var diario = get_node(path_al_diario) as Diario


func agregar_carta(director: Director, detalles: Dictionary):
	var nombre_carta = detalles['nombre_carta']
	diario.agregar_carta(nombre_carta)
	$"../../ui/menu/boton_abrir_diario/Notificacion".visible = true
	director.termino_la_ejecucion_de_la_accion()
