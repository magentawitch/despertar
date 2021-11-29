extends Node


export var path_al_contenedor_de_la_carta: NodePath
onready var contenedor_carta = get_node(path_al_contenedor_de_la_carta) as Position2D

func ver_carta(director: Director, detalles: Dictionary):
	var nombre_carta = detalles['nombre_carta']
	contenedor_carta.mostrar_carta(nombre_carta)
	yield(contenedor_carta, "presiono_continuar")
	director.termino_la_ejecucion_de_la_accion()
