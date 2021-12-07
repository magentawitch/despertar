extends Position2D

class_name MarcaDeEntrada, "res://assets/iconos/import.png"

export(String) var escena_que_conecta


func _ready():
	add_to_group('MarcasDeEntrada')

func teleportar_jade_si_venia_de(nombre_escena_anterior: String, next):
	if escena_que_conecta == nombre_escena_anterior:
		next.teleportar_jade(self)
