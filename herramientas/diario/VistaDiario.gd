extends Node2D
class_name VistaDiario, "./VistaDiario.icon.png"

signal solicitaron_cerrarme

var pagina_actual = 0

export(NodePath) var diario_path
func diario() -> Diario:
	return get_node(diario_path) as Diario
	
func mostrar():
	print("mostrando diario")
	recargar()
	show()
	
func ocultar():
	hide()
	print("ocultando diario")

func _ready():
	self.recargar()

func recargar():
	print("Recargando vista del diario")
	var entradas_izquierda = diario().entradas_de_la_pagina(pagina_actual)
	$izquierda.recargar_entradas(entradas_izquierda)
	
	if diario().cantidad_de_paginas_ocupadas() > pagina_actual + 1:
		var entradas_derecha = diario().entradas_de_la_pagina(pagina_actual + 1)
		$derecha.recargar_entradas(entradas_derecha)
	else:
		$derecha.limpiar_entradas()
	
func cambiar_pagina_izquierda():
	if pagina_actual > 0:
		pagina_actual -= 2
		recargar()
		
func cambiar_pagina_derecha():
	var paginas = diario().cantidad_de_paginas_ocupadas()
	if pagina_actual + 2 < paginas:
		pagina_actual += 2
		recargar()
	

func is_click(event):
	return event is InputEventMouseButton and event.is_pressed()
		
func _on_AreaIrIzquierda_input_event(viewport, event, shape_idx):
	if is_click(event):
		cambiar_pagina_izquierda()


func _on_AreaIrDerecha_input_event(viewport, event, shape_idx):
	if is_click(event):
		cambiar_pagina_derecha()


func _on_AreaCerrar_input_event(viewport, event, shape_idx):
	if is_click(event):
		print("solicitaron_cerrarme")
		emit_signal("solicitaron_cerrarme")
		mostrar_cursor_normal()

func mostrar_cursor_como_dedito():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func mostrar_cursor_normal():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

