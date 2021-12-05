extends Node

export(NodePath) var path_a_la_memoria
onready var memoria = get_node(path_a_la_memoria) as Memoria


func nueva_partida(director: Director, detalles: Dictionary):
	memoria.guardar_partida({
		"diario": {
			"entradas": [],
			"hitos": [],
		},
		"nombre_escena_actual": "00_diario"
	})
	director.encolar("cargar_partida", {})
	director.termino_la_ejecucion_de_la_accion()
