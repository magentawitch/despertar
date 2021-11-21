extends VBoxContainer

export var es_izquierda: bool
var pagina_siguiente: Control
var pagina_anterior: Control

func _ready():
	limpiar_entradas()

func es_pagina_izquierda() -> bool:
	return es_izquierda
	
func es_pagina_derecha() -> bool:
	return not es_izquierda
	
func limpiar_entradas():
	for c in get_children():
		c.queue_free()

func _instanciar_entrada(tipo):
	return EntradaDeDiario.cargar(tipo)

func agregar_entrada_si_hay_lugar(entrada) -> bool:
	print("Agregando entrada si hay lugar")
	var tamanio_original = rect_size.y
	print("- El tamanio es ", tamanio_original)
	var node = yield(agregar_entrada(entrada), 'completed')
	# posiblemente haya que llamar a algo para recalcular el tamanio del container
	if rect_size.y > tamanio_original:
		print("- Ha crecido, ahora es ", rect_size.y, ", sacando entrada")
		node.queue_free()
		yield(get_tree(), "idle_frame")
		set_size(Vector2(rect_size.x, tamanio_original))
		return false
	else:
		print("- El tamanio no ha cambiado")
		return true

func agregar_entrada(entrada) -> MarginContainer:
	print("Agregando entrada")
	var node = _instanciar_entrada(entrada['tipo'])
	node.inicializar_con(entrada)
	add_child(node)
	yield(get_tree(), "idle_frame")
	return node
