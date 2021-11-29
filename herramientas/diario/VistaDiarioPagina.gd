extends VBoxContainer

export var es_izquierda: bool
var pagina_siguiente: Control
var pagina_anterior: Control

var tamanio_original = null

## accion: String, detalles: Dictionary
signal solicita_ejecutar_accion 

func _ready():
	limpiar_entradas()
	tamanio_original = rect_size.y
	connect("resized", self, "on_resized")
	
func on_resized():
	print("Resized!")

func es_pagina_izquierda() -> bool:
	return es_izquierda
	
func es_pagina_derecha() -> bool:
	return not es_izquierda
	
func limpiar_entradas():
	for c in get_children():
		c.queue_free()

func _instanciar_entrada(tipo):
	return EntradaDeDiario.cargar(tipo)

# yeilds
func agregar_entrada(entrada) -> MarginContainer:
	print("Agregando entrada")
	var node = _instanciar_entrada(entrada['tipo'])
	node.inicializar_con(entrada)
	add_child(node)
	yield(get_tree(), "idle_frame")
	node.connect('solicita_ejecutar_accion', self, '_cuando_una_entrada_solicita_ejecutar_accion')
	yield(get_tree(), "idle_frame")
	if tamanio_original and rect_size.y > tamanio_original:
		print("Crecio mas de lo que recordaba, a ver, vamos a probar achicarlo")
		set_size(Vector2(rect_size.x, tamanio_original))
		yield(get_tree(), "idle_frame")
	return node
	
func _cuando_una_entrada_solicita_ejecutar_accion(accion: String, detalles: Dictionary):
	emit_signal("solicita_ejecutar_accion", accion, detalles)

# yeilds
func agregar_entrada_si_hay_lugar(entrada) -> bool:
	print("Agregando entrada si hay lugar")
	if tamanio_original and rect_size.y > tamanio_original:
		print("Estoy mas grande de lo que recordaba, a ver, vamos a probar achicarlo")
		set_size(Vector2(rect_size.x, tamanio_original))
		yield(get_tree(), "idle_frame")
	# tamanio_original = rect_size.y
	print("- El tamanio es ", tamanio_original)
	var node = yield(agregar_entrada(entrada), 'completed')
	# posiblemente haya que llamar a algo para recalcular el tamanio del container
	print("- Midiendo tamaño de nuevo")
	if rect_size.y > tamanio_original:
		print("- Ha crecido, ahora es ", rect_size.y, ", sacando entrada")
		node.queue_free()
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		set_size(Vector2(rect_size.x, tamanio_original))
		return false
	else:
		print("- El tamanio no ha cambiado")
		return true
