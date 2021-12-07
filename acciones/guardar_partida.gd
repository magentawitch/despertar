extends Node

export var path_al_diario: NodePath
onready var diario = get_node(path_al_diario) as Diario

export(NodePath) var path_al_contenedor_de_escena
onready var contenedor_de_escena = get_node(path_al_contenedor_de_escena) as ContenedorDeEscena

export(NodePath) var path_a_la_memoria
onready var memoria = get_node(path_a_la_memoria) as Memoria

export(NodePath) var path_al_spinner_de_guardado
onready var spinner_de_guardado = get_node(path_al_spinner_de_guardado)


func guardar_partida(director: Director, detalles: Dictionary):
	memoria.guardar_partida({
		"diario": {
			"entradas": diario.entradas,
			"hitos": diario.hitos,
		},
		"nombre_escena_actual": contenedor_de_escena.nombre_de_la_escena_actual,
		"nombre_escena_anterior": contenedor_de_escena.nombre_de_la_escena_anterior,
	})
	spinner_de_guardado.mostrar_y_ocultar()
	director.termino_la_ejecucion_de_la_accion()
