extends Node2D
class_name VistaDiario, "./VistaDiario.icon.png"

signal solicitaron_cerrarme

var pagina_actual = 0
var interactivo = true

func botones_habilitados():
	return interactivo

export(NodePath) var diario_path
func diario() -> Diario:
	return get_node(diario_path) as Diario
	
func mostrar():
	print("mostrando diario")
	interactivo = true
	$botones.visible = true
	# Vamos a la ultima pagina par
	pagina_actual = diario().cantidad_de_paginas_ocupadas() - 1
	pagina_actual -= pagina_actual % 2
	recargar()
	show()
	
func mostrar_de_forma_no_interactiva():
	print("mostrando diario de forma no interactiva")
	interactivo = false
	$botones.visible = false
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
		$derecha.recargar_entradas([])
		
	$botones/anterior_pagina.visible = pagina_actual > 0
	$botones/siguiente_pagina.visible = pagina_actual < diario().cantidad_de_paginas_ocupadas() - 2
	
func cambiar_pagina_izquierda():
	if pagina_actual > 0:
		pagina_actual -= 2
		recargar()
		
func cambiar_pagina_derecha():
	var paginas = diario().cantidad_de_paginas_ocupadas()
	if pagina_actual + 2 < paginas:
		pagina_actual += 2
		recargar()
	

func _on_anterior_pagina_pressed() -> void:
	if not botones_habilitados():
		return
	cambiar_pagina_izquierda()


func _on_siguiente_pagina_pressed() -> void:
	if not botones_habilitados():
		return
	cambiar_pagina_derecha()


func _on_cerrar_diario_pressed() -> void:
	if not botones_habilitados():
		return
	print("solicitaron_cerrarme")
	emit_signal("solicitaron_cerrarme")
