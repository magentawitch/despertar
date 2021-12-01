extends TextureButton
class_name ObjectoInteractivo, "res://assets/iconos/button1.png"

export var on_pressed_cue: AudioStream
export var on_mouse_entered_cue: AudioStream
export var on_mouse_exited_cue: AudioStream

onready var _forma_de_cursor_guardada = mouse_default_cursor_shape
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
	mouse_default_cursor_shape = _forma_de_cursor_guardada

func deshabilitar_interaccion():
	disabled = true
	mouse_default_cursor_shape = Control.CURSOR_ARROW
