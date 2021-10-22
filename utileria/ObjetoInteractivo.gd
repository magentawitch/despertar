extends TextureButton
class_name ObjectoInteractivo, "res://assets/iconos/joystick.png"

onready var forma_de_cursor_guardada = mouse_default_cursor_shape

func rehabilitar_interaccion():
	disabled = false
	mouse_default_cursor_shape = forma_de_cursor_guardada

func deshabilitar_interaccion():
	disabled = true
	mouse_default_cursor_shape = Control.CURSOR_ARROW
