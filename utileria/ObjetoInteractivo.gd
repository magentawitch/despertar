extends TextureButton
class_name ObjectoInteractivo, "res://assets/iconos/button1.png"

export var on_pressed_cue: AudioStream
export var on_mouse_entered_cue: AudioStream
export var on_mouse_exited_cue: AudioStream

const CURSOR_PARA_OBJETOS_INTERACTIVOS = 2#CURSOR_POINTING_HAND
var player: AudioStreamPlayer

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)
	deshabilitar_interaccion()
	connect("pressed", self, "play_sound", [on_pressed_cue])
	connect("mouse_entered", self, "play_sound", [on_mouse_entered_cue])
	connect("mouse_exited", self, "play_sound", [on_mouse_exited_cue])
	
func play_sound(auidio_stream: AudioStream):
	if not auidio_stream or disabled:
		return
	if player.playing:
		player.stop()
	player.stream = auidio_stream
	player.play()
	

func rehabilitar_interaccion():
	disabled = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_default_cursor_shape = CURSOR_PARA_OBJETOS_INTERACTIVOS

func deshabilitar_interaccion():
	disabled = true
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	mouse_default_cursor_shape = Control.CURSOR_ARROW
