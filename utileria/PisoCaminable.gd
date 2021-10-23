extends Area2D

class_name PisoCaminable, "res://assets/iconos/arrowDown.png"

func _ready() -> void:
	pass # Replace with function body.
	connect("mouse_entered", self, "mostar_puntero_caminar")
	connect("mouse_exited", self, "mostar_puntero_normal")
	visible = true

func mostar_puntero_caminar():
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)

func mostar_puntero_normal():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
