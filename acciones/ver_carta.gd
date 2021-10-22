extends Node


export var contenedor_de_la_carta: NodePath

func contenedor() -> Position2D:
	return get_node(contenedor_de_la_carta) as Position2D

func ver_carta(director: Director, detalles: Dictionary):
	var carta = detalles['carta']
	contenedor().mostrar_carta(carta)
	yield(contenedor(), "presiono_continuar")
	director.termino_la_ejecucion_de_la_accion()
