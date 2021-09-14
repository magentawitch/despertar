extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var EntradaRenglon = preload("./EntradaRenglon.tscn")

func limpiar_entradas():
	for c in $Contenido.get_children():
		$Contenido.remove_child(c)

func recargar_entradas(entradas):
	print("Recargando entradas de pagina")
	limpiar_entradas()
	var upper_left_corner = -$Forma.get_shape().get_extents()
	var page_height = $Forma.get_shape().get_extents().y * 2
	var current_pos = upper_left_corner
	for entrada in entradas:
		match entrada["tipo"]:
			"renglon":
				var node = EntradaRenglon.instance()
				node.set_text(entrada["texto"])
				$Contenido.add_child(node)
				node.set_position(current_pos)
				
			var t:
				push_error("Tipo de entrada desconocida: " + t)
				assert(false)
		current_pos.y += entrada["tamanio"] * page_height / 100
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
