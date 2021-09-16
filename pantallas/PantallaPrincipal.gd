extends Node2D


var nombre_de_la_escena_actual: String = "patio_de_juegos"

func _ready() -> void:
	cargar_escena_actual()
	
func cargar_escena_actual():
	assert(
		nombre_de_la_escena_actual != null,
		"No hay una escena para cargar"
	)
	var escena = cargar_escena(nombre_de_la_escena_actual)
	
	escena.inicializar_dependencias($director, $diario)
	$contenedor.add_child(escena, true)
	escena.set_name('escena_actual')
	call_deferred('avisar_que_la_escena_fue_cargada')
	
func avisar_que_la_escena_fue_cargada():
	pass

func cargar_escena(nombre_de_la_escena) -> Escena:
	var archivo_de_la_escena = "res://escenas/%s.tscn" % nombre_de_la_escena
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la escena: %s, deberia estar en: %s" % [
			nombre_de_la_escena_actual, archivo_de_la_escena
		]
	)
	return load(archivo_de_la_escena).instance() as Escena

	
