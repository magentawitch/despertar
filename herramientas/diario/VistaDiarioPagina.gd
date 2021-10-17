extends Control


var EntradaTexto = preload("./EntradaTexto.tscn")

func _ready():
	limpiar_entradas()

func limpiar_entradas():
	for c in get_children():
		c.queue_free()

func instanciar_entrada(entrada):
	var tipo = entrada["tipo"]
	match tipo:
		"texto":
			var t = EntradaTexto.instance()
			t.inicializar_con(entrada)
			return t
		"foto":
			var archivo_de_la_escena = "res://fotos/%s.tscn" % entrada["escena_foto"]
			assert(
				ResourceLoader.exists(archivo_de_la_escena),
				"No existe la foto: %s, deberia estar en: %s" % [
					entrada["escena_foto"], archivo_de_la_escena
				]
			)
			return load(archivo_de_la_escena).instance()
		var t:
			push_error("Tipo de entrada desconocida: " + t)
			assert(false)

func recargar_entradas(entradas):
	print("Recargando entradas de pagina")
	limpiar_entradas()
	for entrada in entradas:
		var node = instanciar_entrada(entrada)
		add_child(node)
	
