extends Node
class_name Foco

export(NodePath) var path_al_contenedor_de_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_escena) as Node2D

var personaje_objetivo: Personaje = null

func obtener_personaje_objetivo() -> Personaje:
	return personaje_objetivo

func enfocar_personaje_objetivo():
	personaje_objetivo = _buscar_personaje_dfs(contenedor_de_escena)

func _buscar_personaje_dfs(nodo) -> Personaje:
	for c in nodo.get_children():
		if c is Personaje:
			return c
		var p = _buscar_personaje_dfs(c)
		if p:
			return p
	return null

