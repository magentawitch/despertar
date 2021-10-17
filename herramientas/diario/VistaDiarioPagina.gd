extends Control


var EntradaTexto = preload("./EntradaTexto.tscn")

func _ready():
	limpiar_entradas()

func limpiar_entradas():
	for c in get_children():
		c.queue_free()

func instanciar_entrada(tipo):
	match tipo:
		"texto":
			return EntradaTexto.instance()
		var t:
			push_error("Tipo de entrada desconocida: " + t)
			assert(false)

func recargar_entradas(entradas):
	print("Recargando entradas de pagina")
	limpiar_entradas()
	for entrada in entradas:
		var node = instanciar_entrada(entrada["tipo"])
		node.inicializar_con(entrada)
		add_child(node)
	
