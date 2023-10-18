extends Node2D
class_name Foto, "res://assets/iconos/film.png"

func asignar_opcion_de_epigrafe_elegida(opcion_elegida):
	for opcion in $opciones.get_children():
		opcion.visible = opcion_elegida == opcion.name
	
func opciones_de_epigrafe_disponibles() -> Dictionary:
	var opciones = {}
	for opcion in $opciones.get_children():
		opciones[opcion.name] = opcion.get_node("epigrafe").text
	return opciones

static func cargar(nombre_foto: String) -> Foto:
	var archivo_de_la_escena = "res://fotos/%s.tscn" % nombre_foto
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la foto: %s, deberia estar en: %s" % [
			nombre_foto, archivo_de_la_escena
		]
	)
	var foto = load(archivo_de_la_escena).instance() as Foto
	for opcion in foto.get_node('opciones').get_children():
		opcion.visible = false
	Translator.translate_tree(foto)
	return foto
