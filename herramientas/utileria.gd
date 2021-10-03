extends Node

signal gano_interes
signal ocurrio_interaccion
signal perdio_el_interes

var interaccion_habilitada: bool = true

func rehabilitar_interaccion():
	interaccion_habilitada = true

func deshabilitar_interaccion():
	interaccion_habilitada = false

func _ready():
	for nodo in get_children():
		if nodo is Area2D:
			nodo.connect('mouse_entered', self, 'cuando_un_area_gano_interes')
			nodo.connect('mouse_exited',  self, 'cuando_un_area_perdio_el_interes')
			nodo.connect('input_event',   self, 'cuando_se_interactuo_con_un_area_de_alguna_forma')
		
		if nodo is AnimationPlayer:
			self.connect('gano_interes',        nodo, 'play', ['gano_interes'])
			self.connect('ocurrio_interaccion', nodo, 'play', ['ocurrio_interaccion'])
			self.connect('perdio_el_interes',   nodo, 'play', ['perdio_el_interes'])


func cuando_un_area_gano_interes():
	if interaccion_habilitada:
		emit_signal('gano_interes')
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func cuando_un_area_perdio_el_interes():
	if interaccion_habilitada:
		emit_signal('perdio_el_interes')
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func cuando_se_interactuo_con_un_area_de_alguna_forma(viewport, event, shape_idx):
	if interaccion_habilitada and event is InputEventMouseButton and event.is_pressed():
		emit_signal("ocurrio_interaccion")
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
