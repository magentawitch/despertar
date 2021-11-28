extends Area2D

class_name PisoCaminable, "res://assets/iconos/arrowDown.png"

signal quiere_caminar_hacia

func _ready() -> void:
	connect("mouse_entered", self, "mostar_puntero_caminar")
	connect("mouse_exited", self, "mostar_puntero_normal")
	connect("input_event", self, "_on_self_input_event")
	visible = true

func mostar_puntero_caminar():
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)

func mostar_puntero_normal():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func obtener_escena() -> Escena:
	var escena = null
	var root = get_tree().root
	var nodo = get_parent()
	while escena == null:
		assert(
			nodo != root,
			"Un objeto interactivo no pudo obtener la escena en la que se encuentra."
		)
		if nodo is Escena:
			escena = nodo
		else:
			nodo = nodo.get_parent()
	return escena as Escena
		

func _on_self_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emitir_accion_de_caminar()

func emitir_accion_de_caminar():
	var posicion_destino = get_global_mouse_position()
	obtener_escena().camina(posicion_destino)

	
