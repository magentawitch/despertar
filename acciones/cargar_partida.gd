extends Node

export(NodePath) var path_al_diario
onready var diario = get_node(path_al_diario) as Diario

export(NodePath) var path_al_contenedor_de_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_escena) as ContenedorDeEscena

export(NodePath) var path_a_la_memoria
onready var memoria = get_node(path_a_la_memoria) as Memoria

func cargar_partida(director: Director, detalles: Dictionary):
	var p = memoria.cargar_partida()
	diario.cargar_estado(
		p['diario']['entradas'],
		p['diario']['hitos']
	)
	director.encolar(
		"cambio_de_escena",
		{
			"escena": p['nombre_escena_actual'],
			"escena_anterior": p.get('nombre_escena_anterior', ''),
		}
	)
	director.termino_la_ejecucion_de_la_accion()
