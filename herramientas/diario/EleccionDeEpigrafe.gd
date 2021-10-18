extends Node2D
class_name EleccionDeEpigrafe

signal opcion_elegida

func _ready() -> void:
	# Borro las opciones de prueba
	$panel/opciones/opcion_de_prueba_a.queue_free()
	$panel/opciones/opcion_de_prueba_b.queue_free()
	
func mostrar_foto(nombre_foto):
	print("Mostrando foto para elegir el epigrafe")
	var foto = Foto.cargar(nombre_foto)
	asnignar_opciones_disponibles(
		foto.opciones_de_epigrafe_disponibles()
	)
	# mostrar foto
	visible = true

func asnignar_opciones_disponibles(opciones_disponibles: Dictionary):
	# Borro las opciones viejas
	for node in $panel/opciones.get_children():
		node.queue_free()
	# Agrego las que son para esta foto
	for nombre_opcion in opciones_disponibles.keys():
		var texto_opcion = opciones_disponibles[nombre_opcion]
		var button = Button.new()
		button.text = texto_opcion
		button.connect("pressed", self, "_on_opcion_elegida", [nombre_opcion])
		$panel/opciones.add_child(button)

func _on_opcion_elegida(nombre_opcion):
	visible = false
	emit_signal("opcion_elegida", nombre_opcion)
