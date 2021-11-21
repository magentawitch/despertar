extends Node2D
class_name VistaDiario, "./VistaDiario.icon.png"

signal solicitaron_cerrarme

var pagina_actual: Control
var interactivo = true

func cambiar_pagina_actual(nueva_pagina):
	print("[cambio la pagina actual]")
	for node in $paginas.get_children():
		node.hide()
	if nueva_pagina.es_pagina_izquierda():
		nueva_pagina.show()
		if nueva_pagina.pagina_siguiente:
			nueva_pagina.pagina_siguiente.show()
	elif nueva_pagina.es_pagina_derecha():
		nueva_pagina.show()
		if nueva_pagina.pagina_anterior:
			nueva_pagina.pagina_anterior.show()
	pagina_actual = nueva_pagina

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
	diario().connect("entrada_agregada", self, "agregar_entrada")
	limpiar_paginas_de_ejemplo()
	
func limpiar_paginas_de_ejemplo():
	for node in $paginas_ejemplo/derecha.get_children():
		node.queue_free()
	for node in $paginas_ejemplo/izquierda.get_children():
		node.queue_free()

func agregar_entrada(entrada):
	pass
	
func limpiar_entradas():
	print("Limpiando entradas")
	for pagina in $paginas.get_children():
		pagina.queue_free()
	yield(get_tree(), "idle_frame")
	ultima_pagina_con_espacio = $paginas_ejemplo/izquierda.duplicate(7)
	$paginas.add_child(ultima_pagina_con_espacio)

var ultima_pagina_con_espacio

func avanzar_pagina():
	print("Avanzando pagina..")
	if ultima_pagina_con_espacio.name == '1':
		print(".. a la pagina 2")
		ultima_pagina_con_espacio = $paginas.get_node('2')
	else:
		print(".. a una nueva pagina..")
		var pagina_en_blanco = null
		if ultima_pagina_con_espacio.es_pagina_izquierda():
			pagina_en_blanco = $paginas_ejemplo/derecha.duplicate(7)
		if ultima_pagina_con_espacio.es_pagina_derecha():
			pagina_en_blanco = $paginas_ejemplo/izquierda.duplicate(7)
		$paginas.add_child(pagina_en_blanco)
		for node in pagina_en_blanco.get_children():
			node.queue_free()
		ultima_pagina_con_espacio.pagina_siguiente = pagina_en_blanco
		pagina_en_blanco.pagina_anterior = ultima_pagina_con_espacio
		pagina_en_blanco.pagina_siguiente = null
		ultima_pagina_con_espacio = pagina_en_blanco
	yield(get_tree(), "idle_frame")

func recargar():
	print("Recargando vista del diario")
	yield(limpiar_entradas(), 'completed')
	for entrada in diario().obtener_todas_las_entradas():
		var se_pudo = yield(ultima_pagina_con_espacio.agregar_entrada_si_hay_lugar(entrada), "completed")
		if not se_pudo:
			yield(avanzar_pagina(), 'completed')
			yield(ultima_pagina_con_espacio.agregar_entrada(entrada), 'completed')
	cambiar_pagina_actual(ultima_pagina_con_espacio)
	
func cambiar_pagina_izquierda():
	print("Cambiando pagina a la izquierda")
	if pagina_actual.pagina_anterior and pagina_actual.pagina_anterior.pagina_anterior:
		cambiar_pagina_actual(pagina_actual.pagina_anterior.pagina_anterior)
		
func cambiar_pagina_derecha():
	print("Cambiando pagina a la derecha")
	if pagina_actual.pagina_siguiente and pagina_actual.pagina_siguiente.pagina_siguiente:
		cambiar_pagina_actual(pagina_actual.pagina_siguiente.pagina_siguiente)
	

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
