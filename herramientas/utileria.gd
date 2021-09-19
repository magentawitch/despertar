extends Node

signal gano_interes
signal ocurrio_interaccion
signal perdio_el_interes


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
	emit_signal('gano_interes')

func cuando_un_area_perdio_el_interes():
	emit_signal('perdio_el_interes')

func cuando_se_interactuo_con_un_area_de_alguna_forma(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("ocurrio_interaccion")
