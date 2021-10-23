extends Node2D

class_name Carta, "res://assets/iconos/envelope-solid.svg"

export var version_abierta_para_ver: NodePath
export var version_cerrada_para_el_diario: NodePath

func _ready():
	assert(
		version_abierta_para_ver != null,
		"A la carta % falta asignarle una version abierta para verla en pantalla" % name
	)
	assert(
		version_cerrada_para_el_diario != null,
		"A la carta % falta asignarle una version cerrada para mostrar en el diario" % name
	)

func _version_cerrada() -> Control:
	var carta_cerrada = get_node(version_cerrada_para_el_diario)
	assert(
		carta_cerrada is Control,
		"La version cerrada de la %s debe ser un nodo verde (Control)" % name
	)
	return carta_cerrada
	
func _version_abierta() -> Position2D:
	var carta_abierta = get_node(version_abierta_para_ver)
	assert(
		carta_abierta is Position2D,
		"La version abierta de la %s debe ser una posición que represente su centro (Position2D)" % name
	)
	return carta_abierta

static func cargar_carta_abierta(nombre_carta: String):
	return _cargar_escena_carta(nombre_carta)._version_abierta()

static func cargar_carta_cerrada(nombre_carta: String) -> Control:
	return _cargar_escena_carta(nombre_carta)._version_cerrada()
	

static func _cargar_escena_carta(nombre_carta: String) -> Carta:
	var archivo_de_la_escena = "res://cartas/%s.tscn" % nombre_carta
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la carta: %s, deberia estar en: %s" % [
			nombre_carta, archivo_de_la_escena
		]
	)
	return load(archivo_de_la_escena).instance() as Carta