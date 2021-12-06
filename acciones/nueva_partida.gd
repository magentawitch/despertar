extends Node

export(NodePath) var path_a_la_memoria
onready var memoria = get_node(path_a_la_memoria) as Memoria

export(NodePath) var path_al_diario
onready var diario = get_node(path_al_diario) as Diario

export(NodePath) var path_al_contenedor_de_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_escena) as ContenedorDeEscena


func nueva_partida(director: Director, detalles: Dictionary):
	var p = {
		"diario": {
			"entradas": [],
			"hitos": [],
		},
		"nombre_escena_actual": "00_diario"
	}
	diario.cargar_estado(
		p['diario']['entradas'],
		p['diario']['hitos']
	)
	director.encolar("cambio_de_escena", {"escena": p['nombre_escena_actual']})
	director.termino_la_ejecucion_de_la_accion()
