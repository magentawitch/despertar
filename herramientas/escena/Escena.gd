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
