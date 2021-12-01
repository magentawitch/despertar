extends Node2D

class_name ModoDeInteraccion, "res://assets/iconos/target.png"

var contenedor_de_la_escena: ContenedorDeEscena
var director: Director

signal solicito_cambiar_modo # nombre_modo: String


func inicializar_modo(contenedor_de_la_escena: ContenedorDeEscena, director: Director):
	self.director = director
	self.contenedor_de_la_escena = contenedor_de_la_escena

func ocultar_menu_de_acciones_mientras_esta_colocado() -> bool:
	return false

func entrar_al_modo():
	assert(
		false,
		"No implementado"
	)
	
func salir_del_modo():
	assert(
		false,
		"No implementado"
	)

static func cargar(nombre_modo: String) -> ModoDeInteraccion:
	var archivo_de_la_escena = "res://modos_de_interaccion/%s.tscn" % nombre_modo
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe el modo: %s, deberia estar en: %s" % [
			nombre_modo, archivo_de_la_escena
		]
	)
	return load(archivo_de_la_escena).instance() as ModoDeInteraccion
