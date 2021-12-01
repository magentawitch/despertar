extends Node2D

class_name ContenedorDeEscena

const DELAY_ANTES_DE_CARGAR_ESCENA = 1.0

var nombre_de_la_escena_actual: String

export(NodePath) var path_al_director
onready var director = get_node(path_al_director) as Director

export(NodePath) var path_al_diario
onready var diario = get_node(path_al_diario) as Diario

signal se_procedera_a_cargar_una_escena
signal una_escena_fue_cargada


func cambiar_escena(nombre_de_escena_nueva):
	assert(
		true,
		"TODO: Hacer un chequeo de que la escena exista antes de cambiar"
	)
	emit_signal("se_procedera_a_cargar_una_escena")
	
	if nombre_de_la_escena_actual:
		yield(get_tree().create_timer(DELAY_ANTES_DE_CARGAR_ESCENA), "timeout")
	
	var escena_previa = get_child(0)
	if escena_previa:
		escena_previa.queue_free()
		yield(escena_previa, "tree_exited")
	
	nombre_de_la_escena_actual = nombre_de_escena_nueva
	cargar_escena_actual()

func cargar_escena_actual():
	assert(
		nombre_de_la_escena_actual != null,
		"No hay una escena para cargar"
	)
	var escena = Escena.cargar(nombre_de_la_escena_actual)
	escena._inicializar_dependencias(director, diario)
	add_child(escena, true)
	escena.set_name('escena_actual')
	
	# Relacionado a lo que es la camara
	position = Vector2.ZERO
	
	call_deferred('_avisar_que_la_escena_fue_cargada', escena)
	
func obtener_escena_actual() -> Escena:
	return get_child(0) as Escena
	
func _avisar_que_la_escena_fue_cargada(escena: Escena):
	emit_signal("una_escena_fue_cargada", escena)
