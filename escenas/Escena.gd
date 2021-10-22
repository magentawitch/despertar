extends Node2D
class_name Escena, "res://assets/iconos/door.png"

export var puede_abrir_el_diario = true

var diario: Diario
var director: Director

func _inicializar_dependencias(director: Director, diario: Diario):
	self.diario = diario
	self.director = director
	print("Escena: %s inicializada!" % get_name())
	director.connect("aparecieron_acciones_pendientes", self, '_deshabilitar_input', [self])
	director.connect("se_acabaron_las_acciones_pendientes", self, '_rehabilitar_input', [self])

func _deshabilitar_input(nodo):
	print("DESHABILITANDO INPUT")
	for c in nodo.get_children():
		if c.has_method('deshabilitar_interaccion'):
			c.deshabilitar_interaccion()
			_deshabilitar_input(c)

func _rehabilitar_input(nodo):
	print("REHABILITANDO INPUT")
	for c in nodo.get_children():
		if c.has_method('rehabilitar_interaccion'):
			c.rehabilitar_interaccion()
			_rehabilitar_input(c)

func anota_en_el_diario(algo):
	director.encolar("anotar", {"texto": algo.strip_edges()})
	
func agregar_un_salto_de_linea_en_el_diario():
	director.encolar("anotar", {"texto": ""})

func agrega_foto_al_diario(nombre_foto):
	director.encolar("agrega_foto", {"nombre_foto": nombre_foto})

func anotar_en_el_diario(algo):
	anota_en_el_diario(algo)

func protagonista_piensa(algo):
	print(algo)
	
func cinematica(descrpcion):
	pass

func cambiar_escena_a(nombre_de_escena):
	director.encolar("cambio_de_escena", {"escena": nombre_de_escena})

func dice_a_la_grabadora(texto):
	grabar(texto)
	
func se_rie(quien):
	pass
	
func grabar(texto):
	director.encolar("dice", {"texto": texto, "recuadro": "grabadora"})

func dice(quien, dialogo):
	director.encolar("dice", {"texto": dialogo, "recuadro": quien})

func elige(opciones):
	director.encolar('elige', {"opciones": opciones, "responsable": self})