extends TextureButton
class_name AreaFotografeable, "res://assets/iconos/button2.png"

onready var _forma_de_cursor_guardada = mouse_default_cursor_shape

func _ready():
	deshabilitar_sacar_fotos()
	
func habilitar_sacar_fotos():
	disabled = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_default_cursor_shape = _forma_de_cursor_guardada

func deshabilitar_sacar_fotos():
	disabled = true
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	mouse_default_cursor_shape = Control.CURSOR_ARROW
