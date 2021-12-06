extends Node2D
class_name EleccionDeEpigrafe

signal opcion_elegida

func _ready() -> void:
	# Borro las opciones de prueba
	$panel/opciones/prototipo_opcion_de_epigrafe.queue_free()
	$panel/opciones/opcion_de_epigrafe_de_ejemplo.queue_free()
	$lugar_donde_va_la_foto/foto_placeholder_que_se_borra_al_iniciar.queue_free()
	
func mostrar_foto(nombre_foto):
	print("Mostrando foto para elegir el epigrafe")
	visible = true
	modulate.a = 0.1
	var foto = Foto.cargar(nombre_foto)
	asnignar_opciones_disponibles(
		foto.opciones_de_epigrafe_disponibles()
	)
	modulate.a = 1
	$lugar_donde_va_la_foto.add_child(foto)
	mover_lapicera($sobre_la_carta)

func asnignar_opciones_disponibles(opciones_disponibles: Dictionary):
	# Borro las opciones viejas
	for node in $panel/opciones.get_children():
		node.queue_free()
	yield(get_tree(), "idle_frame")
	# Agrego las que son para esta foto
	for nombre_opcion in opciones_disponibles.keys():
		var texto_opcion = opciones_disponibles[nombre_opcion]
		var opcion = OpcionDeEpigrafe.crear()
		$panel/opciones.add_child(opcion)
		opcion.asignar_texto(texto_opcion)
		opcion.connect("fue_elegido", self, "_on_opcion_elegida", [nombre_opcion])
		opcion.connect("gano_interes", self, "_on_opcion_gano_interes", [opcion])
		opcion.connect("perdio_interes", self, "_on_opcion_perdio_interes", [opcion])
		
func _on_opcion_elegida(nombre_opcion):
	visible = false
	emit_signal("opcion_elegida", nombre_opcion)

func _on_opcion_gano_interes(opcion: OpcionDeEpigrafe):
	mover_lapicera(opcion.obtener_posicion_lapicera())

func mover_lapicera(posicion: Position2D):
	$lapicera.global_position = posicion.global_position

func _on_opcion_perdio_interes(opcion: OpcionDeEpigrafe):
	mover_lapicera($sobre_la_carta)
	
