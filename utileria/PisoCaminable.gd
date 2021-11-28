extends Area2D

class_name PisoCaminable, "res://assets/iconos/arrowDown.png"

var deshabilitado = false
var mouse_adentro = false

signal quiere_caminar_hacia


func _ready() -> void:
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("input_event", self, "_on_self_input_event")
	visible = true
	
func _on_mouse_entered():
	mouse_adentro = true
	mostar_puntero_caminar()
	
func _on_mouse_exited():
	mouse_adentro = false
	mostar_puntero_normal()

func mostar_puntero_caminar():
	if not deshabilitado:
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)

func mostar_puntero_normal():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_self_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (not deshabilitado
		and event is InputEventMouseButton
		and event.button_index == BUTTON_LEFT
		and event.pressed):
			emitir_accion_de_caminar()
			mostar_puntero_normal()

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
		
func emitir_accion_de_caminar():
	var posicion_destino = get_global_mouse_position()
	obtener_escena().camina(posicion_destino)


func rehabilitar_interaccion():
	deshabilitado = false
	if mouse_adentro:
		mostar_puntero_caminar()

func deshabilitar_interaccion():
	deshabilitado = true
