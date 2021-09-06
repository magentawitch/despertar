extends Node2D


var pagina_actual = 0

export(NodePath) var diario_path

func _ready():
	self.recargar()
	

func recargar():
	print("Recargando vista del diario")
	var diario = get_node(diario_path)
	var entradas_izquierda = diario.entradas_de_la_pagina(pagina_actual)
	$PaginaIzquierda.recargar_entradas(entradas_izquierda)
	
	if diario.cantidad_de_paginas_ocupadas() > pagina_actual + 1:
		var entradas_derecha = diario.entradas_de_la_pagina(pagina_actual + 1)
		$PaginaDerecha.recargar_entradas(entradas_derecha)
	else:
		$PaginaDerecha.limpiar_entradas()
	
func cambiar_pagina_izquierda():
	if pagina_actual > 0:
		pagina_actual -= 2
		recargar()
		
func cambiar_pagina_derecha():
	var paginas = get_node(diario_path).cantidad_de_paginas_ocupadas()
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
		pass
