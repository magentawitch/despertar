extends Node
class_name Escena

var diario: Diario
var director: Director

func inicializar_dependencias(director: Director, diario: Diario):
	self.diario = diario
	self.director = director
	print("Escena: %s inicializada!" % get_name())


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
