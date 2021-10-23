extends Area2D

class_name PisoCaminable, "res://assets/iconos/arrowDown.png"

signal quiere_caminar_hacia

onready var personaje = _buscar_personaje_dfs(get_tree().root)

# TODO: Ya está copypasteado, buscar lugar mejor
func _buscar_personaje_dfs(nodo) -> Personaje:
	for c in nodo.get_children():
		if c is Personaje:
			return c
		var p = _buscar_personaje_dfs(c)
		if p:
			return p
	return null

func _ready() -> void:
	connect("mouse_entered", self, "mostar_puntero_caminar")
	connect("mouse_exited", self, "mostar_puntero_normal")
	connect("input_event", self, "_on_self_input_event")
	visible = true

func mostar_puntero_caminar():
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)

func mostar_puntero_normal():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_self_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			personaje.caminar_hacia(get_global_mouse_position())

	
