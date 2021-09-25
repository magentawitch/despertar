extends Node


const escena_dialogo = preload('res://herramientas/dialogo/cuadro_de_dialogo.tscn')

export var contenedor_del_dialogo: NodePath

func contenedor() -> Node2D:
	return get_node(contenedor_del_dialogo) as Node2D

func dice(director: Director, detalles: Dictionary):
	var dialogo = escena_dialogo.instance()
	dialogo.asignar_texto(detalles['texto'])
	dialogo.connect("presiono_continuar", self, 'presiono_continuar_en_el_dialogo', [director, dialogo])
	contenedor().add_child(dialogo)

func presiono_continuar_en_el_dialogo(director: Director, dialogo: Node2D):
	dialogo.queue_free()
	director.termino_la_ejecucion_de_la_accion()
