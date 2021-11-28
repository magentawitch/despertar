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

static func cargar(nombre_de_la_escena: String) -> Escena:
	var archivo_de_la_escena = "res://escenas/%s.tscn" % nombre_de_la_escena
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la escena: %s, deberia estar en: %s" % [
			nombre_de_la_escena, archivo_de_la_escena
		]
	)
	var escena = load(archivo_de_la_escena).instance()
	assert(
		true, # escena is Escena, 
		"""La escena: %s no es del tipo Escena. TIP: Tiene que tener
		un script attacheado que arranque con: `extends Escena`""" % [escena]
		## Parece que godot no puede llamar `x is X` dentro de funciones estáticas
	)
	return escena as Escena

	
func _deshabilitar_input(nodo):
	for c in nodo.get_children():
		if c.has_method('deshabilitar_interaccion'):
			c.deshabilitar_interaccion()
			_deshabilitar_input(c)

func _rehabilitar_input(nodo):
	for c in nodo.get_children():
		if c.has_method('rehabilitar_interaccion'):
			c.rehabilitar_interaccion()
			_rehabilitar_input(c)

func anota_en_el_diario(algo: String):
	var renglones = algo.strip_edges().split('\n')
	var texto = ''
	for renglon in renglones:
		texto += renglon.strip_edges() + '\n'
	director.encolar("anotar", {"texto": texto + "\n"})
	
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
	
func ver_carta(nombre_de_carta):
	director.encolar("ver_carta", {"carta": nombre_de_carta})

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

