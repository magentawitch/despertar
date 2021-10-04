extends Node2D
class_name Escena, "./icono.png"

var diario: Diario
var director: Director

func _inicializar_dependencias(director: Director, diario: Diario):
	self.diario = diario
	self.director = director
	print("Escena: %s inicializada!" % get_name())
	director.connect("aparecieron_acciones_pendientes", self, '_deshabilitar_input')
	director.connect("se_acabaron_las_acciones_pendientes", self, '_rehabilitar_input')

func _deshabilitar_input():
	# TODO: Esto deberia ser recursivo, que pasa si el hijo de un hijo tiene input
	for c in get_children():
		if c.has_method('deshabilitar_interaccion'):
			c.deshabilitar_interaccion()
			
	
func _rehabilitar_input():
	# TODO: Esto deberia ser recursivo, que pasa si el hijo de un hijo tiene input
	for c in get_children():
		if c.has_method('rehabilitar_interaccion'):
			c.rehabilitar_interaccion()

func anotar_en_el_diario(algo):
	director.encolar("anotar", {"texto": algo})

func protagonista_piensa(algo):
	print(algo)

func cambiar_escena_a(nombre_de_escena):
	director.encolar("cambio_de_escena", {"escena": nombre_de_escena})

func grabar(texto):
	director.encolar("dice", {"texto": texto, "recuadro": "grabadora"})

func dice(quien, dialogo):
	director.encolar("dice", {"texto": dialogo, "recuadro": quien})

func elige(opciones):
	director.encolar('elige', {"opciones": opciones, "responsable": self})
