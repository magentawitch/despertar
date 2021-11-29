extends Node2D

class_name ContenedorDeEscena

const DELAY_ANTES_DE_CARGAR_ESCENA = 1.0

export var nombre_de_la_escena_de_prueba: String = "02_pasillo_escuela"
export var nombre_de_la_escena_actual: String = "00_diario"

export(NodePath) var path_al_director
onready var director = get_node(path_al_director) as Director

export(NodePath) var path_al_diario
onready var diario = get_node(path_al_diario) as Diario

signal se_procedera_a_cargar_una_escena
signal una_escena_fue_cargada


func _ready():
	if OS.is_debug_build():
		print("Como estoy en debug arranco con la escena de test: ", nombre_de_la_escena_de_prueba)
		nombre_de_la_escena_actual = nombre_de_la_escena_de_prueba
	call_deferred('cargar_escena_actual')

func cambiar_escena(nombre_de_escena_nueva):
	assert(
		true,
		"TODO: Hacer un chequeo de que la escena exista antes de cambiar"
	)
	emit_signal("se_procedera_a_cargar_una_escena")
	
	yield(get_tree().create_timer(DELAY_ANTES_DE_CARGAR_ESCENA), "timeout")
	
	var escena_previa = get_child(0)
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
	
func _avisar_que_la_escena_fue_cargada(escena: Escena):
	emit_signal("una_escena_fue_cargada", escena)
