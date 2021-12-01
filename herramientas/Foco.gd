extends Node2D
class_name Foco

export(NodePath) var path_al_contenedor_de_la_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_la_escena) as ContenedorDeEscena

export(NodePath) var path_al_director
onready var director = get_node(path_al_director) as Director

var personaje_activo: Personaje = null

signal cambio_de_modo


func obtener_personaje_activo() -> Personaje:
	enfocar_personaje_activo()
	return personaje_activo

func enfocar_personaje_activo():
	personaje_activo = _buscar_personaje_dfs(contenedor_de_escena)

func _buscar_personaje_dfs(nodo) -> Personaje:
	for c in nodo.get_children():
		if c is Personaje:
			return c
		var p = _buscar_personaje_dfs(c)
		if p:
			return p
	return null

var modo: ModoDeInteraccion = null

func entrar_en_modo_de_accion():
	salir_de_cualquier_modo()

func entrar_en_modo_de_interaccion():
	cambiar_modo("interactuar")

func cambiar_modo(nombre_modo: String):
	salir_de_cualquier_modo()
	entrar_en_modo(nombre_modo)
	emit_signal("cambio_de_modo", modo)

func entrar_en_modo(nombre_modo: String):
	modo = ModoDeInteraccion.cargar(nombre_modo)
	add_child(modo)
	modo.connect("solicito_cambiar_modo", self, "cambiar_modo")
	modo.inicializar_modo(contenedor_de_escena, director)
	modo.entrar_al_modo()
	
func salir_de_cualquier_modo():
	if not modo:
		return
	modo.salir_del_modo()
	modo.queue_free()
	modo = null
