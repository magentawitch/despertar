extends Node2D


var pagina_actual = 0

export(NodePath) var diario_path

func _ready():
	self.recargar()
	

func recargar():
	print("Recargando vista del diario")
	var diario = get_node(diario_path)
	var entradas_izquierda = diario.entradas_de_la_pagina(self.pagina_actual)
	$PaginaIzquierda.recargar_entradas(entradas_izquierda)
	
	if diario.cantidad_de_paginas_ocupadas() > self.pagina_actual + 1:
		var entradas_derecha = diario.entradas_de_la_pagina(self.pagina_actual + 1)
		$PaginaDerecha.recargar_entradas(entradas_derecha)
	
