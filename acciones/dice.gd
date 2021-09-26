extends Node


const escena_dialogo = preload('res://herramientas/dialogo/cuadro_de_dialogo.tscn')

export var contenedor_del_dialogo: NodePath

func contenedor() -> Node2D:
	return get_node(contenedor_del_dialogo) as Node2D

func dice(director: Director, detalles: Dictionary):
	var dialogo = escena_dialogo.instance()
	dialogo.asignar_texto(detalles['texto'])
	if detalles.has('recuadro'):
		dialogo.mostrar_recuadro(detalles['recuadro'])
	contenedor().add_child(dialogo)
	yield(dialogo, "presiono_continuar")
	dialogo.queue_free()
	director.termino_la_ejecucion_de_la_accion()
