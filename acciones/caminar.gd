extends Node

export var path_al_foco: NodePath
onready var foco = get_node(path_al_foco) as Foco

func caminar(director: Director, detalles: Dictionary) -> void:
	var posicion_destino = detalles['posicion_destino']
	var personaje = foco.obtener_personaje_objetivo()
	assert(
		personaje != null,
		"Se intentó caminar cuando no había un personaje objetivo en la escena."
	)
	personaje.caminar_hacia(posicion_destino)
	yield(personaje, "llegue_al_destino")
	director.termino_la_ejecucion_de_la_accion()
